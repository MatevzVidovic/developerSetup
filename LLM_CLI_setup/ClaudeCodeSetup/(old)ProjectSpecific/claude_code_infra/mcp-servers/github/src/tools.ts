import { exec } from 'child_process';

// --- Type Definitions for Tool Arguments ---
interface CreateIssueArgs {
  repo: string;
  title: string;
  body: string;
  labels?: string[];
}

interface ListIssuesArgs {
  repo: string;
  limit?: number;
}

// --- Internal Helper ---
function executeCommand(command: string): Promise<string> {
  return new Promise((resolve, reject) => {
    exec(command, (error, stdout, stderr) => {
      if (error) {
        reject({ message: error.message, details: stderr });
        return;
      }
      resolve(stdout);
    });
  });
}

// --- Tool Implementations ---
export async function createIssue({ repo, title, body, labels = [] }: CreateIssueArgs): Promise<string> {
  if (!repo || !title || !body) {
    throw new Error("Missing required arguments: repo, title, body");
  }
  let command = `gh issue create --repo "${repo}" --title "${title}" --body "${body}"`;
  if (labels.length > 0) {
    command += ` --label "${labels.join(',')}"`;
  }
  return executeCommand(command);
}

export async function listIssues({ repo, limit = 30 }: ListIssuesArgs): Promise<any> {
  if (!repo) {
    throw new Error("Missing required argument: repo");
  }
  const command = `gh issue list --repo "${repo}" --limit ${limit} --json number,title,state,author,labels`;
  const result = await executeCommand(command);
  return JSON.parse(result);
}