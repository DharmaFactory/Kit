#!/usr/bin/env tsx
import { spawnSync } from 'child_process'
import fs from 'fs'
import path from 'path'

interface Options {
  pipeline?: string
  label?: string
  inputFile?: string
  summary?: string
  force?: boolean
}

function parseArgs(argv: string[]): Options {
  const opts: Options = {}
  for (let i = 0; i < argv.length; i++) {
    const arg = argv[i]
    switch (arg) {
      case '--pipeline':
      case '-p':
        opts.pipeline = argv[++i]
        break
      case '--label':
      case '-l':
        opts.label = argv[++i]
        break
      case '--input':
      case '-i':
        opts.inputFile = argv[++i]
        break
      case '--summary':
      case '-s':
        opts.summary = argv[++i]
        break
      case '--force':
      case '-f':
        opts.force = true
        break
      default:
        console.error(`Unknown argument: ${arg}`)
        process.exit(1)
    }
  }
  return opts
}

function usage(): never {
  console.log(`Usage: npx tsx scripts/run_pipeline.ts --pipeline <name> --input <request.json> --label <slug> [--summary "brief intent"] [--force]`)
  process.exit(1)
}

function extractJsonPayload(text: string) {
  const trimmed = text.trim()
  for (let idx = trimmed.lastIndexOf('{'); idx >= 0; idx = trimmed.lastIndexOf('{', idx - 1)) {
    const candidate = trimmed.slice(idx)
    try {
      return JSON.parse(candidate)
    } catch (_) {
      continue
    }
  }
  throw new Error('Unable to parse JSON output from pipeline run.')
}

function main() {
  const opts = parseArgs(process.argv.slice(2))
  if (!opts.pipeline || !opts.inputFile || !opts.label) usage()

  const inputPath = path.resolve(opts.inputFile)
  if (!fs.existsSync(inputPath)) {
    console.error(`Input file not found: ${inputPath}`)
    process.exit(1)
  }
  const inputPayload = JSON.parse(fs.readFileSync(inputPath, 'utf8'))

  const today = new Date()
  const dateStr = today.toISOString().slice(0, 10)
  const timestamp = today.toISOString()

  const baseLogDir = path.join('logs', 'baml')
  const dayDir = path.join(baseLogDir, dateStr)
  fs.mkdirSync(dayDir, { recursive: true })

  const outputFile = path.join(dayDir, `${opts.label}.json`)
  if (fs.existsSync(outputFile) && !opts.force) {
    console.error(`Output file already exists (${outputFile}). Use --force to overwrite.`)
    process.exit(1)
  }

  // Execute existing CLI
  const cliArgs = [
    '--yes',
    'tsx',
    'kit2/modules/baml-openrouter/src/index.ts',
    '--pipeline',
    opts.pipeline,
    '--input',
    JSON.stringify(inputPayload)
  ]
  const result = spawnSync('npx', cliArgs, { encoding: 'utf8' })
  if (result.error) {
    console.error('Failed to execute pipeline:', result.error)
    process.exit(1)
  }
  if (result.status !== 0) {
    console.error(result.stdout)
    console.error(result.stderr)
    console.error(`Pipeline exited with status ${result.status}`)
    process.exit(result.status ?? 1)
  }

  const stdout = (result.stdout || '') + (result.stderr || '')
  const parsedOutput = extractJsonPayload(stdout)

  fs.writeFileSync(outputFile, JSON.stringify(parsedOutput, null, 2))

  const computeLogEntry = {
    timestamp,
    pipeline: opts.pipeline,
    label: opts.label,
    summary: opts.summary || '',
    input_file: path.relative('.', inputPath),
    output_file: path.relative('.', outputFile),
    uncertainty: typeof parsedOutput?.uncertainty === 'number' ? parsedOutput.uncertainty : null
  }
  const computeLogPath = path.join(baseLogDir, 'compute-log.jsonl')
  fs.appendFileSync(computeLogPath, JSON.stringify(computeLogEntry) + '\n')

  console.log('Pipeline run recorded:')
  console.log(JSON.stringify(computeLogEntry, null, 2))
}

main()
