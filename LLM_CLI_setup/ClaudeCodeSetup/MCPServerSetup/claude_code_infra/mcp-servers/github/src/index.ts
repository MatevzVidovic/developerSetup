import express from 'express';
import { createIssue, listIssues } from './tools.js';
import { exec } from 'child_process';

const app = express();
app.use(express.json());

const PORT = 3000;

const TOOLS = {
  create_github_issue: createIssue,
  list_github_issues: listIssues,
};

// Define the keys of the TOOLS object as a type for type safety
type ToolName = keyof typeof TOOLS;

interface RequestBody {
  toolName: ToolName;
  args: any;
}

// Authenticate with GitHub CLI on start
if (process.env.GH_TOKEN) {
  exec(`echo "${process.env.GH_TOKEN}" | gh auth login --with-token`, (error, stdout, stderr) => {
      if (error) {
          console.error(`GitHub auth error: ${error.message}`);
          return;
      }
      if (stderr) {
          // Don't treat warnings as fatal, but log them
          console.warn(`GitHub auth stderr: ${stderr}`);
      }
      console.log(`GitHub auth stdout: Successfully authenticated.`);
  });
} else {
  console.warn("GH_TOKEN not set. GitHub MCP server will not be able to authenticate.");
}


app.post('/', async (req, res) => {
  const { toolName, args } = req.body as RequestBody;

  if (!toolName || !(toolName in TOOLS)) {
    return res.status(400).json({ error: `Tool '${toolName}' not found.` });
  }

  try {
    const result = await TOOLS[toolName](args);
    res.json({ result });
  } catch (error) {
    console.error(`Error executing tool ${toolName}:`, error);
    const errorMessage = error instanceof Error ? error.message : 'An unknown error occurred';
    res.status(500).json({ error: errorMessage });
  }
});

app.listen(PORT, () => {
  console.log(`GitHub MCP Server listening on port ${PORT}`);
});