#!/usr/bin/env node
/**
 * BAML OpenRouter CLI
 * Executes BAML pipelines for MAVEN/CHROMA narrative analysis
 */

import 'dotenv/config';
import { b } from '../baml_client/index.js';

interface CLIArgs {
  pipeline: string;
  input: string;
}

function parseArgs(): CLIArgs {
  const args = process.argv.slice(2);
  const result: Partial<CLIArgs> = {};

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--pipeline' && i + 1 < args.length) {
      result.pipeline = args[i + 1];
      i++;
    } else if (args[i] === '--input' && i + 1 < args.length) {
      result.input = args[i + 1];
      i++;
    }
  }

  if (!result.pipeline || !result.input) {
    console.error('Usage: tsx src/index.ts --pipeline <pipeline_name> --input <json_input>');
    console.error('');
    console.error('Available pipelines:');
    console.error('  - AnalyzeNarrative');
    console.error('  - GenerateCounterRitual');
    console.error('  - PerformSerologicScan');
    process.exit(1);
  }

  return result as CLIArgs;
}

async function main() {
  const { pipeline, input } = parseArgs();

  // Validate environment
  if (!process.env.OPENROUTER_API_KEY) {
    console.error('Error: OPENROUTER_API_KEY not found in environment');
    console.error('Create a .env file with: OPENROUTER_API_KEY=sk-or-v1-...');
    process.exit(1);
  }

  try {
    // Parse input JSON
    const inputData = JSON.parse(input);

    let result;

    // Execute requested pipeline
    switch (pipeline) {
      case 'AnalyzeNarrative':
      case 'analyze_narrative':
      case 'probe_narrative':
        if (!inputData.snippet || !inputData.objective) {
          throw new Error('AnalyzeNarrative requires: { snippet: string, objective: string }');
        }
        result = await b.AnalyzeNarrative(inputData.snippet, inputData.objective);
        break;

      case 'GenerateCounterRitual':
      case 'generate_counter_ritual':
      case 'draft_counter':
        if (!inputData.infection_pattern || !inputData.desired_outcome) {
          throw new Error('GenerateCounterRitual requires: { infection_pattern: string, desired_outcome: string }');
        }
        result = await b.GenerateCounterRitual(inputData.infection_pattern, inputData.desired_outcome);
        break;

      case 'PerformSerologicScan':
      case 'perform_serologic_scan':
      case 'serologic_scan':
        if (!inputData.snippet) {
          throw new Error('PerformSerologicScan requires: { snippet: string }');
        }
        result = await b.PerformSerologicScan(inputData.snippet);
        break;

      default:
        throw new Error(`Unknown pipeline: ${pipeline}. Available: AnalyzeNarrative, GenerateCounterRitual, PerformSerologicScan`);
    }

    // Output result as JSON to stdout
    console.log(JSON.stringify(result, null, 2));
    process.exit(0);

  } catch (error) {
    if (error instanceof Error) {
      console.error('Error:', error.message);
      if (error.stack) {
        console.error(error.stack);
      }
    } else {
      console.error('Unknown error:', error);
    }
    process.exit(1);
  }
}

main();
