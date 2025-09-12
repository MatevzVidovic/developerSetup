import axios from 'axios';
import { GoogleGenerativeAI } from '@google/generative-ai';

// --- Type Definitions for Tool Arguments ---
interface OpenRouterArgs {
  model: string;
  prompt: string;
  siteUrl?: string;
  appName?: string;
}

interface GoogleArgs {
  model?: string;
  prompt: string;
}

// --- API Client Initialization ---
const googleApiKey = process.env.GOOGLE_API_KEY;
if (!googleApiKey) {
  // We don't throw an error here, but the consultGoogle function will be disabled.
  console.warn("GOOGLE_API_KEY is not set. The consult_google tool will not be available.");
}
const genAI = googleApiKey ? new GoogleGenerativeAI(googleApiKey) : null;

// --- Tool Implementations ---
export async function consultOpenRouter({ model, prompt, siteUrl = 'http://localhost:3000', appName = 'ClaudeCodeZenMCP' }: OpenRouterArgs) {
  if (!process.env.OPENROUTER_API_KEY) {
    throw new Error("OPENROUTER_API_KEY is not set in the environment variables.");
  }
  const response = await axios.post('https://openrouter.ai/api/v1/chat/completions', {
    model: model,
    messages: [{ role: 'user', content: prompt }],
  }, {
    headers: {
      'Authorization': `Bearer ${process.env.OPENROUTER_API_KEY}`,
      'HTTP-Referer': siteUrl, // Recommended by OpenRouter
      'X-Title': appName,      // Recommended by OpenRouter
    }
  });
  return response.data.choices[0].message.content;
}

export async function consultGoogle({ model = 'gemini-pro', prompt }: GoogleArgs) {
  if (!genAI) {
    throw new Error("Google API client is not initialized. Check if GOOGLE_API_KEY is set.");
  }
  const geminiModel = genAI.getGenerativeModel({ model });
  const result = await geminiModel.generateContent(prompt);
  const response = await result.response;
  return response.text();
}