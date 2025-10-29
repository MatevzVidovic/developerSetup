import express from 'express';
import { consultOpenRouter, consultGoogle } from './tools.js';

const app = express();
app.use(express.json());

const PORT = 3000;

const TOOLS = {
  consult_openrouter: consultOpenRouter,
  consult_google: consultGoogle,
};

// Define the keys of the TOOLS object as a type for type safety
type ToolName = keyof typeof TOOLS;

interface RequestBody {
  toolName: ToolName;
  args: any;
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
  console.log(`Zen MCP Server listening on port ${PORT}`);
});