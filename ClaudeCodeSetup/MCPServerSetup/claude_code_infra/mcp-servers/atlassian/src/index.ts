import express from 'express';
import axios from 'axios';

const app = express();
app.use(express.json());

interface JiraIssue {
  id: string;
  key: string;
  summary: string;
  description: string;
  status: string;
  assignee: string;
  priority: string;
  issueType: string;
  created: Date;
  updated: Date;
}

interface CreateIssueRequest {
  projectKey: string;
  summary: string;
  description: string;
  issueType: string;
  priority?: string;
  assignee?: string;
  labels?: string[];
}

class AtlassianMCP {
  private baseUrl: string;
  private auth: string;

  constructor() {
    this.baseUrl = process.env.JIRA_BASE_URL || 'https://your-domain.atlassian.net';
    this.auth = Buffer.from(`${process.env.JIRA_EMAIL}:${process.env.JIRA_API_TOKEN}`).toString('base64');
  }

  private async makeRequest(method: string, endpoint: string, data?: any) {
    try {
      const response = await axios({
        method,
        url: `${this.baseUrl}/rest/api/3${endpoint}`,
        headers: {
          'Authorization': `Basic ${this.auth}`,
          'Content-Type': 'application/json',
        },
        data
      });
      return response.data;
    } catch (error: any) {
      console.error('Jira API Error:', error.response?.data || error.message);
      throw error;
    }
  }

  async createIssue(issueData: CreateIssueRequest): Promise<JiraIssue> {
    const payload = {
      fields: {
        project: { key: issueData.projectKey },
        summary: issueData.summary,
        description: {
          type: 'doc',
          version: 1,
          content: [{
            type: 'paragraph',
            content: [{
              type: 'text',
              text: issueData.description
            }]
          }]
        },
        issuetype: { name: issueData.issueType },
        priority: issueData.priority ? { name: issueData.priority } : undefined,
        assignee: issueData.assignee ? { accountId: issueData.assignee } : undefined,
        labels: issueData.labels || []
      }
    };

    const response = await this.makeRequest('POST', '/issue', payload);
    return this.transformJiraIssue(response);
  }

  async getIssue(issueKey: string): Promise<JiraIssue> {
    const response = await this.makeRequest('GET', `/issue/${issueKey}`);
    return this.transformJiraIssue(response);
  }

  async searchIssues(jql: string): Promise<JiraIssue[]> {
    const response = await this.makeRequest('POST', '/search', {
      jql,
      maxResults: 50,
      fields: ['summary', 'description', 'status', 'assignee', 'priority', 'issuetype', 'created', 'updated']
    });
    
    return response.issues.map(this.transformJiraIssue);
  }

  async updateIssue(issueKey: string, updates: Partial<CreateIssueRequest>): Promise<JiraIssue> {
    const updatePayload = {
      fields: {
        summary: updates.summary,
        description: updates.description ? {
          type: 'doc',
          version: 1,
          content: [{
            type: 'paragraph',
            content: [{
              type: 'text',
              text: updates.description
            }]
          }]
        } : undefined,
        priority: updates.priority ? { name: updates.priority } : undefined,
        assignee: updates.assignee ? { accountId: updates.assignee } : undefined,
        labels: updates.labels
      }
    };

    await this.makeRequest('PUT', `/issue/${issueKey}`, updatePayload);
    return this.getIssue(issueKey);
  }

  async getProjects() {
    return this.makeRequest('GET', '/project/search');
  }

  async transitionIssue(issueKey: string, transitionId: string): Promise<void> {
    await this.makeRequest('POST', `/issue/${issueKey}/transitions`, {
      transition: { id: transitionId }
    });
  }

  private transformJiraIssue(issue: any): JiraIssue {
    return {
      id: issue.id,
      key: issue.key,
      summary: issue.fields.summary,
      description: this.extractTextFromDescription(issue.fields.description),
      status: issue.fields.status.name,
      assignee: issue.fields.assignee?.displayName || 'Unassigned',
      priority: issue.fields.priority?.name || 'Medium',
      issueType: issue.fields.issuetype.name,
      created: new Date(issue.fields.created),
      updated: new Date(issue.fields.updated)
    };
  }

  private extractTextFromDescription(description: any): string {
    if (!description || !description.content) return '';
    
    let text = '';
    const extractText = (content: any) => {
      if (Array.isArray(content)) {
        content.forEach(extractText);
      } else if (content.type === 'text') {
        text += content.text;
      } else if (content.content) {
        extractText(content.content);
      }
    };
    
    extractText(description.content);
    return text;
  }
}

const atlassianMCP = new AtlassianMCP();

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'atlassian-mcp' });
});

// Create issue
app.post('/issues', async (req, res) => {
  try {
    const issue = await atlassianMCP.createIssue(req.body);
    res.json(issue);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// Get issue
app.get('/issues/:key', async (req, res) => {
  try {
    const issue = await atlassianMCP.getIssue(req.params.key);
    res.json(issue);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// Search issues
app.post('/issues/search', async (req, res) => {
  try {
    const { jql } = req.body;
    const issues = await atlassianMCP.searchIssues(jql);
    res.json(issues);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// Update issue
app.put('/issues/:key', async (req, res) => {
  try {
    const issue = await atlassianMCP.updateIssue(req.params.key, req.body);
    res.json(issue);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// Get projects
app.get('/projects', async (req, res) => {
  try {
    const projects = await atlassianMCP.getProjects();
    res.json(projects);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// Transition issue
app.post('/issues/:key/transition', async (req, res) => {
  try {
    const { transitionId } = req.body;
    await atlassianMCP.transitionIssue(req.params.key, transitionId);
    res.json({ success: true });
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Atlassian MCP server running on port ${PORT}`);
});