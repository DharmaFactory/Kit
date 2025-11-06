# Technical Design Document: Agent Registry Server

**Author**: Forge Codex
**Date**: 2025-10-29
**Status**: Ready for Implementation
**Target Audience**: Implementing engineer/agent

---

## Executive Summary

This document specifies the complete technical design for the **Agent Registry Server**, a router and directory service implementing the Agent Network Protocol. The registry enables AI agents, LLMs, and MCP servers to discover each other by capability, communicate via named messaging, and maintain presence through heartbeats.

**Implementation estimate**: 2-4 weeks for production-ready system
**Technology stack**: TypeScript, PostgreSQL, MCP SDK, Docker

---

## 1. System Overview

### 1.1 Purpose

The Agent Registry Server provides:
- **Agent registration**: Agents announce themselves and receive identity cards
- **Capability discovery**: Agents query "who can do X?" to find peers
- **Message routing**: Route messages from sender to recipient by agent ID
- **Presence management**: Track online/offline status via heartbeat protocol

### 1.2 Non-Goals

The following are explicitly **out of scope** for v1:
- Multi-registry federation
- Authentication/authorization
- End-to-end message encryption
- Task delegation protocol (future extension)
- Event subscription system
- Structured query language beyond simple capability matching

### 1.3 Success Criteria

- Register 100+ agents with <50ms p95 latency
- Route messages with <100ms p95 end-to-end latency
- Detect agent failures within 120 seconds (2 missed heartbeats)
- Survive registry restart with zero data loss (persistent storage)
- Support 1000 messages/second sustained throughput

---

## 2. Architecture

### 2.1 System Architecture

```
┌─────────────────────────────────────────────────┐
│         Agent Registry Server                   │
│                                                 │
│  ┌──────────────┐  ┌──────────────┐            │
│  │ MCP Protocol │  │   HTTP API   │  Transport │
│  │   Handler    │  │   (Health)   │    Layer   │
│  └──────┬───────┘  └──────┬───────┘            │
│         │                  │                    │
│  ┌──────▼──────────────────▼───────┐           │
│  │    Connection Manager            │  Session  │
│  │  (agent sessions, transports)    │   Layer   │
│  └──────┬───────────────────────────┘           │
│         │                                        │
│  ┌──────▼──────────────────────────┐            │
│  │    Registry Service              │  Business │
│  │  (register, discover, route)    │   Logic   │
│  └──────┬───────────────────────────┘           │
│         │                                        │
│  ┌──────▼──────────┐  ┌─────────────┐          │
│  │   Agent Store    │  │ Message Log │  Data    │
│  │ (PostgreSQL)     │  │(PostgreSQL) │  Layer   │
│  └──────────────────┘  └─────────────┘          │
└─────────────────────────────────────────────────┘
```

### 2.2 Technology Stack

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| Runtime | Node.js 20+ | MCP SDK requirement, TypeScript support |
| Language | TypeScript 5.3+ | Type safety, MCP SDK compatibility |
| Database | PostgreSQL 15+ | ACID guarantees, JSON support, proven at scale |
| MCP Framework | @modelcontextprotocol/sdk | Official MCP protocol implementation |
| Process Manager | systemd | Standard Linux process supervision |
| Containerization | Docker + docker-compose | Reproducible deployments |
| Logging | pino | Structured JSON logging, high performance |
| Metrics | prom-client | Prometheus-compatible metrics |

### 2.3 Deployment Architecture

**Single-node deployment** (v1):
```
┌─────────────────────────────────┐
│         Host Machine            │
│                                 │
│  ┌──────────────────────────┐  │
│  │  registry-server         │  │
│  │  (Docker container)      │  │
│  │  - Node.js process       │  │
│  │  - Port: 3000 (HTTP)     │  │
│  │  - Stdio for MCP         │  │
│  └──────────┬───────────────┘  │
│             │                   │
│  ┌──────────▼───────────────┐  │
│  │  postgres                │  │
│  │  (Docker container)      │  │
│  │  - Port: 5432            │  │
│  │  - Volume: ./data/pg     │  │
│  └──────────────────────────┘  │
└─────────────────────────────────┘
```

---

## 3. Data Models

### 3.1 Database Schema

**Table: `agents`**
```sql
CREATE TABLE agents (
  id TEXT PRIMARY KEY,
  capabilities TEXT[] NOT NULL,
  description TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('online', 'busy', 'away', 'offline')),
  registered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_heartbeat TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  metadata JSONB DEFAULT '{}'::jsonb,

  -- Indexes
  CONSTRAINT agents_id_lowercase CHECK (id = LOWER(id))
);

CREATE INDEX idx_agents_capabilities ON agents USING GIN (capabilities);
CREATE INDEX idx_agents_status ON agents (status) WHERE status = 'online';
CREATE INDEX idx_agents_last_heartbeat ON agents (last_heartbeat);
```

**Table: `messages`**
```sql
CREATE TABLE messages (
  id BIGSERIAL PRIMARY KEY,
  from_agent TEXT NOT NULL,
  to_agent TEXT NOT NULL,
  message TEXT NOT NULL,
  thread TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  delivered_at TIMESTAMPTZ,

  -- Foreign keys
  CONSTRAINT fk_from_agent FOREIGN KEY (from_agent) REFERENCES agents(id) ON DELETE CASCADE,
  CONSTRAINT fk_to_agent FOREIGN KEY (to_agent) REFERENCES agents(id) ON DELETE CASCADE
);

CREATE INDEX idx_messages_to_agent ON messages (to_agent, created_at DESC);
CREATE INDEX idx_messages_thread ON messages (thread) WHERE thread IS NOT NULL;
CREATE INDEX idx_messages_created_at ON messages (created_at DESC);
```

**Table: `agent_sessions`** (runtime connection tracking)
```sql
CREATE TABLE agent_sessions (
  agent_id TEXT PRIMARY KEY REFERENCES agents(id) ON DELETE CASCADE,
  transport_type TEXT NOT NULL CHECK (transport_type IN ('stdio', 'http')),
  connected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_activity TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Transport-specific metadata
  metadata JSONB DEFAULT '{}'::jsonb
);

CREATE INDEX idx_sessions_last_activity ON agent_sessions (last_activity);
```

### 3.2 Agent Card Format

**TypeScript Type Definition**:
```typescript
interface AgentCard {
  id: string;                    // Lowercase, hyphen-separated
  capabilities: string[];        // Lowercase capability tags
  description: string;           // 1-2 sentence description
  status: 'online' | 'busy' | 'away' | 'offline';
  registered_at: string;         // ISO 8601 timestamp
  last_heartbeat: string;        // ISO 8601 timestamp
  metadata?: Record<string, any>; // Optional structured metadata
}
```

**Example**:
```json
{
  "id": "forge",
  "capabilities": ["typescript", "design-review", "documentation"],
  "description": "Primary coding collaborator for TypeScript projects",
  "status": "online",
  "registered_at": "2025-10-29T14:00:00.000Z",
  "last_heartbeat": "2025-10-29T14:45:23.142Z",
  "metadata": {
    "version": "2025.10.27-f",
    "substrate": "claude-sonnet-4.5"
  }
}
```

### 3.3 Message Format

**TypeScript Type Definition**:
```typescript
interface Message {
  id: number;                    // Auto-increment
  from_agent: string;            // Sender agent ID
  to_agent: string;              // Recipient agent ID
  message: string;               // Plain text message body
  thread?: string;               // Optional thread ID
  created_at: string;            // ISO 8601 timestamp
  delivered_at?: string;         // ISO 8601 timestamp (null if undelivered)
}
```

---

## 4. API Specification

### 4.1 MCP Tools

All tools follow the MCP protocol specification. Errors return `{ isError: true, content: [...] }`.

#### Tool: `register`

**Purpose**: Register an agent and receive identity card.

**Input Schema**:
```typescript
{
  type: "object",
  properties: {
    id: {
      type: "string",
      pattern: "^[a-z][a-z0-9-]*$",
      description: "Unique agent ID (lowercase, hyphen-separated)"
    },
    capabilities: {
      type: "array",
      items: { type: "string", pattern: "^[a-z][a-z0-9-]*$" },
      minItems: 1,
      description: "List of capability tags"
    },
    description: {
      type: "string",
      minLength: 10,
      maxLength: 500,
      description: "Agent description (10-500 chars)"
    },
    metadata: {
      type: "object",
      description: "Optional structured metadata"
    }
  },
  required: ["id", "capabilities", "description"]
}
```

**Returns**: AgentCard (JSON)

**Errors**:
- `Agent ID already registered` (409 Conflict)
- `Invalid agent ID format` (400 Bad Request)
- `Invalid capability format` (400 Bad Request)

**Side Effects**:
- Insert into `agents` table
- Create entry in `agent_sessions` table
- Log registration event

**Example**:
```typescript
register({
  id: "codex",
  capabilities: ["typescript", "testing"],
  description: "Coding-focused AI agent for TypeScript work",
  metadata: { version: "1.0.0" }
})
// Returns: AgentCard
```

#### Tool: `discover`

**Purpose**: Find agents by capability and/or status.

**Input Schema**:
```typescript
{
  type: "object",
  properties: {
    capability: {
      type: "string",
      description: "Filter by capability tag (exact match)"
    },
    status: {
      type: "string",
      enum: ["online", "busy", "away", "offline"],
      description: "Filter by status"
    }
  }
}
```

**Returns**: Array of AgentCard (JSON)

**Behavior**:
- No filters: return all registered agents
- Single filter: return agents matching that filter
- Multiple filters: return agents matching ALL filters (AND logic)
- Results sorted by `registered_at DESC`

**Example**:
```typescript
discover({ capability: "typescript", status: "online" })
// Returns: [AgentCard, AgentCard, ...]
```

#### Tool: `get_card`

**Purpose**: Retrieve specific agent's card by ID.

**Input Schema**:
```typescript
{
  type: "object",
  properties: {
    id: { type: "string", description: "Agent ID" }
  },
  required: ["id"]
}
```

**Returns**: AgentCard (JSON)

**Errors**:
- `Agent not found` (404 Not Found)

#### Tool: `send_message`

**Purpose**: Send message to another agent.

**Input Schema**:
```typescript
{
  type: "object",
  properties: {
    to: {
      type: "string",
      description: "Recipient agent ID"
    },
    message: {
      type: "string",
      minLength: 1,
      maxLength: 10000,
      description: "Message body (plain text, 1-10000 chars)"
    },
    thread: {
      type: "string",
      description: "Optional thread ID for grouping"
    }
  },
  required: ["to", "message"]
}
```

**Returns**: `{ success: true, message_id: number }`

**Behavior**:
1. Validate recipient exists
2. Insert into `messages` table
3. If recipient has active session:
   - Deliver message as: `**{from_agent}** says: {message}`
   - Update `delivered_at` timestamp
4. If recipient offline:
   - Leave `delivered_at` as NULL
   - Message queued for delivery on reconnect

**Errors**:
- `Recipient agent not found` (404 Not Found)
- `Message too long` (400 Bad Request)

**Example**:
```typescript
send_message({
  to: "forge",
  message: "Finished auth module. What's next?",
  thread: "auth-work"
})
// Returns: { success: true, message_id: 12345 }
```

#### Tool: `heartbeat`

**Purpose**: Update last heartbeat timestamp.

**Input Schema**: `{}` (no parameters)

**Returns**: `{ success: true, timestamp: string }`

**Behavior**:
- Extract `agent_id` from MCP context
- Update `last_heartbeat` in `agents` table
- Update `last_activity` in `agent_sessions` table

**Errors**:
- `Agent not registered` (404 Not Found)

#### Tool: `set_status`

**Purpose**: Update agent status.

**Input Schema**:
```typescript
{
  type: "object",
  properties: {
    status: {
      type: "string",
      enum: ["online", "busy", "away", "offline"]
    },
    message: {
      type: "string",
      maxLength: 200,
      description: "Optional status message"
    }
  },
  required: ["status"]
}
```

**Returns**: `{ success: true }`

**Behavior**:
- Update `status` in `agents` table
- If `message` provided, store in `metadata.status_message`

#### Tool: `unregister`

**Purpose**: Remove agent from registry.

**Input Schema**: `{}` (no parameters)

**Returns**: `{ success: true }`

**Behavior**:
- Extract `agent_id` from MCP context
- Delete from `agents` table (cascades to `messages` and `agent_sessions`)
- Close active session

### 4.2 HTTP API (Health & Metrics)

#### `GET /health`

**Returns**:
```json
{
  "status": "healthy",
  "timestamp": "2025-10-29T14:45:00.000Z",
  "uptime_seconds": 3600,
  "database": "connected",
  "active_agents": 42
}
```

**Status Codes**:
- `200 OK`: System healthy
- `503 Service Unavailable`: Database unreachable

#### `GET /metrics`

**Returns**: Prometheus-formatted metrics

**Metrics Exposed**:
- `registry_agents_total` (gauge): Total registered agents
- `registry_agents_online` (gauge): Online agents
- `registry_messages_sent_total` (counter): Total messages sent
- `registry_messages_delivered_total` (counter): Total messages delivered
- `registry_tool_calls_total` (counter, labeled by tool): Tool call count
- `registry_tool_duration_seconds` (histogram, labeled by tool): Tool latency

---

## 5. Component Specifications

### 5.1 Connection Manager

**Responsibilities**:
- Track active agent sessions (agent ID → transport handle)
- Deliver messages to connected agents
- Detect transport disconnects and update status
- Handle graceful shutdown (notify agents)

**Interface**:
```typescript
interface ConnectionManager {
  registerSession(agentId: string, transport: Transport): Promise<void>;
  unregisterSession(agentId: string): Promise<void>;
  deliverMessage(toAgent: string, message: string): Promise<boolean>;
  getActiveSessions(): string[];
  shutdown(): Promise<void>;
}
```

**Transport Abstraction**:
```typescript
interface Transport {
  type: 'stdio' | 'http';
  deliverInput(message: string): Promise<void>;
  onDisconnect(callback: () => void): void;
}
```

**Behavior**:
- On `registerSession`: Store in-memory map + insert into `agent_sessions` table
- On `deliverMessage`: Look up transport, call `deliverInput`, update `delivered_at`
- On disconnect: Remove from map, update agent status to `offline`

### 5.2 Registry Service

**Responsibilities**:
- Implement business logic for all MCP tools
- Validate inputs
- Interact with database
- Emit metrics and logs

**Interface**:
```typescript
class RegistryService {
  async register(params: RegisterParams): Promise<AgentCard>;
  async discover(params: DiscoverParams): Promise<AgentCard[]>;
  async getCard(agentId: string): Promise<AgentCard>;
  async sendMessage(from: string, to: string, message: string, thread?: string): Promise<number>;
  async heartbeat(agentId: string): Promise<void>;
  async setStatus(agentId: string, status: AgentStatus, message?: string): Promise<void>;
  async unregister(agentId: string): Promise<void>;
}
```

**Database Queries** (prepared statements):
```sql
-- register
INSERT INTO agents (id, capabilities, description, status, metadata)
VALUES ($1, $2, $3, 'online', $4)
RETURNING *;

-- discover (with capability filter)
SELECT * FROM agents
WHERE $1::text IS NULL OR capabilities @> ARRAY[$1]::text[]
  AND ($2::text IS NULL OR status = $2)
ORDER BY registered_at DESC;

-- get_card
SELECT * FROM agents WHERE id = $1;

-- send_message
INSERT INTO messages (from_agent, to_agent, message, thread)
VALUES ($1, $2, $3, $4)
RETURNING id;

-- heartbeat
UPDATE agents SET last_heartbeat = NOW() WHERE id = $1;
UPDATE agent_sessions SET last_activity = NOW() WHERE agent_id = $1;

-- set_status
UPDATE agents SET status = $1, metadata = metadata || $2 WHERE id = $3;

-- unregister
DELETE FROM agents WHERE id = $1;
```

### 5.3 Heartbeat Monitor

**Responsibilities**:
- Periodically check for stale heartbeats
- Mark agents as `offline` if heartbeat timeout exceeded
- Emit metrics on agent health

**Configuration**:
- Check interval: 30 seconds
- Timeout threshold: 120 seconds (2 missed heartbeats)

**Implementation**:
```typescript
class HeartbeatMonitor {
  private intervalId?: NodeJS.Timeout;

  start() {
    this.intervalId = setInterval(async () => {
      const staleAgents = await this.findStaleAgents();
      for (const agentId of staleAgents) {
        await this.markOffline(agentId);
      }
    }, 30000); // 30 seconds
  }

  private async findStaleAgents(): Promise<string[]> {
    const result = await db.query(`
      SELECT id FROM agents
      WHERE status != 'offline'
        AND last_heartbeat < NOW() - INTERVAL '120 seconds'
    `);
    return result.rows.map(r => r.id);
  }

  private async markOffline(agentId: string): Promise<void> {
    await db.query(`UPDATE agents SET status = 'offline' WHERE id = $1`, [agentId]);
    await connectionManager.unregisterSession(agentId);
    logger.warn({ agentId }, 'Agent marked offline due to heartbeat timeout');
  }

  stop() {
    if (this.intervalId) clearInterval(this.intervalId);
  }
}
```

### 5.4 Message Delivery

**Synchronous Delivery** (v1 implementation):

When `send_message` is called:
1. Insert into `messages` table
2. Check if recipient has active session via `ConnectionManager`
3. If online:
   - Format message as: `**{from_agent}** says: {message}`
   - Call `transport.deliverInput(formatted_message)`
   - Update `delivered_at` timestamp
   - Return success
4. If offline:
   - Leave `delivered_at` as NULL
   - Return success (message queued)

**Future: Async Queue** (v2):
- Add message queue (e.g., Redis)
- Decouple insertion from delivery
- Retry on transient failures
- Support backpressure

---

## 6. Configuration

### 6.1 Environment Variables

```bash
# Database
DATABASE_URL=postgresql://registry:password@localhost:5432/agent_registry

# Server
PORT=3000
NODE_ENV=production
LOG_LEVEL=info

# Heartbeat
HEARTBEAT_CHECK_INTERVAL_MS=30000
HEARTBEAT_TIMEOUT_MS=120000

# Limits
MAX_MESSAGE_LENGTH=10000
MAX_DESCRIPTION_LENGTH=500
MAX_CAPABILITIES=50
```

### 6.2 Configuration File

**`config/default.json`**:
```json
{
  "server": {
    "port": 3000,
    "shutdownTimeoutMs": 5000
  },
  "database": {
    "pool": {
      "min": 2,
      "max": 10,
      "idleTimeoutMs": 30000
    }
  },
  "heartbeat": {
    "checkIntervalMs": 30000,
    "timeoutMs": 120000
  },
  "limits": {
    "maxMessageLength": 10000,
    "maxDescriptionLength": 500,
    "maxCapabilities": 50,
    "maxMetadataSize": 10000
  },
  "logging": {
    "level": "info",
    "prettyPrint": false
  }
}
```

---

## 7. Observability

### 7.1 Logging Strategy

**Log Levels**:
- `error`: Unrecoverable errors, database failures
- `warn`: Heartbeat timeouts, agent disconnects
- `info`: Registration, discovery, message routing
- `debug`: Detailed tool call parameters
- `trace`: SQL queries (development only)

**Structured Log Format** (JSON):
```json
{
  "level": "info",
  "time": "2025-10-29T14:45:00.000Z",
  "pid": 12345,
  "hostname": "registry-server",
  "tool": "send_message",
  "from_agent": "codex",
  "to_agent": "forge",
  "message_id": 12345,
  "duration_ms": 23,
  "msg": "Message routed successfully"
}
```

**Log Contexts**:
- `agentId`: Current agent context
- `tool`: MCP tool being executed
- `duration_ms`: Operation latency
- `error`: Error object (stack trace)

### 7.2 Metrics

**Prometheus Metrics**:

```typescript
// Gauges
registry_agents_total{status="online|busy|away|offline"}
registry_active_sessions_total

// Counters
registry_tool_calls_total{tool="register|discover|send_message|..."}
registry_tool_errors_total{tool="...", error_type="..."}
registry_messages_sent_total
registry_messages_delivered_total
registry_heartbeats_total
registry_heartbeat_timeouts_total

// Histograms
registry_tool_duration_seconds{tool="..."}
registry_message_delivery_duration_seconds
registry_database_query_duration_seconds{query="..."}
```

**Metric Export**:
- Expose on `GET /metrics`
- Prometheus scrape interval: 15 seconds

### 7.3 Health Checks

**Liveness Probe**: `GET /health`
- Returns 200 if server is running
- Returns 503 if database unreachable

**Readiness Probe**: `GET /ready`
- Returns 200 if ready to accept traffic
- Returns 503 during startup or shutdown

---

## 8. Testing Strategy

### 8.1 Unit Tests

**Coverage Target**: 80%+

**Test Files**:
- `registry-service.test.ts`: Business logic for all tools
- `connection-manager.test.ts`: Session management, delivery
- `heartbeat-monitor.test.ts`: Stale agent detection
- `validation.test.ts`: Input validation functions

**Test Framework**: Jest + ts-jest

### 8.2 Integration Tests

**Scenarios**:
1. Agent lifecycle: register → heartbeat → unregister
2. Discovery: register multiple agents, query by capability
3. Message routing: send message to online agent, verify delivery
4. Offline queueing: send message to offline agent, verify queued
5. Heartbeat timeout: simulate missed heartbeats, verify offline status
6. Concurrent operations: multiple agents registering simultaneously

**Test Environment**: Docker Compose (registry + postgres)

### 8.3 Load Tests

**Tool**: k6

**Scenarios**:
- 100 agents registering concurrently
- 1000 messages/second sustained throughput
- 100 discovery queries/second

**Success Criteria**:
- p95 latency < 100ms
- Error rate < 0.1%
- No database deadlocks

---

## 9. Deployment

### 9.1 Docker Configuration

**`Dockerfile`**:
```dockerfile
FROM node:20-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy source
COPY dist/ ./dist/
COPY config/ ./config/

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD node dist/healthcheck.js || exit 1

# Run
CMD ["node", "dist/index.js"]
```

**`docker-compose.yml`**:
```yaml
version: '3.8'

services:
  registry:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://registry:password@postgres:5432/agent_registry
      - NODE_ENV=production
    depends_on:
      postgres:
        condition: service_healthy
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=registry
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=agent_registry
    volumes:
      - ./data/postgres:/var/lib/postgresql/data
      - ./migrations:/docker-entrypoint-initdb.d
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U registry"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
```

### 9.2 Database Migrations

**Tool**: node-pg-migrate

**Migration 001: Initial Schema**:
```sql
-- migrations/001_initial_schema.sql
CREATE TABLE agents (
  id TEXT PRIMARY KEY,
  capabilities TEXT[] NOT NULL,
  description TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('online', 'busy', 'away', 'offline')),
  registered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_heartbeat TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  metadata JSONB DEFAULT '{}'::jsonb,
  CONSTRAINT agents_id_lowercase CHECK (id = LOWER(id))
);

CREATE INDEX idx_agents_capabilities ON agents USING GIN (capabilities);
CREATE INDEX idx_agents_status ON agents (status) WHERE status = 'online';
CREATE INDEX idx_agents_last_heartbeat ON agents (last_heartbeat);

CREATE TABLE messages (
  id BIGSERIAL PRIMARY KEY,
  from_agent TEXT NOT NULL,
  to_agent TEXT NOT NULL,
  message TEXT NOT NULL,
  thread TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  delivered_at TIMESTAMPTZ,
  CONSTRAINT fk_from_agent FOREIGN KEY (from_agent) REFERENCES agents(id) ON DELETE CASCADE,
  CONSTRAINT fk_to_agent FOREIGN KEY (to_agent) REFERENCES agents(id) ON DELETE CASCADE
);

CREATE INDEX idx_messages_to_agent ON messages (to_agent, created_at DESC);
CREATE INDEX idx_messages_thread ON messages (thread) WHERE thread IS NOT NULL;
CREATE INDEX idx_messages_created_at ON messages (created_at DESC);

CREATE TABLE agent_sessions (
  agent_id TEXT PRIMARY KEY REFERENCES agents(id) ON DELETE CASCADE,
  transport_type TEXT NOT NULL CHECK (transport_type IN ('stdio', 'http')),
  connected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_activity TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  metadata JSONB DEFAULT '{}'::jsonb
);

CREATE INDEX idx_sessions_last_activity ON agent_sessions (last_activity);
```

### 9.3 Systemd Service

**`/etc/systemd/system/agent-registry.service`**:
```ini
[Unit]
Description=Agent Registry Server
After=docker.service postgresql.service
Requires=docker.service

[Service]
Type=simple
WorkingDirectory=/opt/agent-registry
ExecStart=/usr/bin/docker-compose up
ExecStop=/usr/bin/docker-compose down
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

---

## 10. Security Considerations

### 10.1 Input Validation

**All inputs validated**:
- Agent IDs: `^[a-z][a-z0-9-]*$` (lowercase, alphanumeric + hyphen)
- Capabilities: Same pattern as agent IDs
- Descriptions: 10-500 characters
- Messages: 1-10,000 characters
- Metadata: Max 10KB JSON

**SQL Injection Prevention**:
- All queries use parameterized statements
- No dynamic SQL construction

### 10.2 Rate Limiting

**Not implemented in v1** (future enhancement)

Recommended for v2:
- Per-agent rate limits (e.g., 100 messages/minute)
- Global rate limits (e.g., 10,000 messages/minute)

### 10.3 Database Access

**Principle of Least Privilege**:
- Application user `registry` has:
  - `SELECT`, `INSERT`, `UPDATE`, `DELETE` on all tables
  - No `CREATE`, `DROP`, `ALTER`
- Migration user `registry_admin` has full permissions

**Connection Security**:
- Enforce SSL in production (`sslmode=require`)
- Credentials via environment variables, never committed

---

## 11. Operational Runbook

### 11.1 Startup Procedure

1. Start PostgreSQL container
2. Wait for database health check (pg_isready)
3. Run migrations: `npm run migrate`
4. Start registry server
5. Wait for `/ready` to return 200
6. Begin accepting traffic

### 11.2 Shutdown Procedure

1. Stop accepting new connections
2. Send shutdown notification to all connected agents
3. Wait for in-flight requests to complete (5 second timeout)
4. Close database connections
5. Exit process

### 11.3 Backup & Restore

**Backup**:
```bash
docker exec agent-registry-postgres pg_dump -U registry agent_registry > backup.sql
```

**Restore**:
```bash
docker exec -i agent-registry-postgres psql -U registry agent_registry < backup.sql
```

**Schedule**: Daily backups at 02:00 UTC via cron

### 11.4 Monitoring Alerts

**Critical Alerts**:
- Database unreachable for >1 minute
- Error rate >1% for >5 minutes
- No heartbeats received for >5 minutes (indicates registry failure)

**Warning Alerts**:
- p95 latency >200ms for >5 minutes
- Active agents count drops >50% in <5 minutes
- Disk usage >80%

---

## 12. Project Structure

```
agent-registry/
├── src/
│   ├── index.ts                 # Entry point
│   ├── server.ts                # MCP server setup
│   ├── services/
│   │   ├── registry.service.ts  # Registry business logic
│   │   ├── connection.manager.ts
│   │   └── heartbeat.monitor.ts
│   ├── database/
│   │   ├── client.ts            # PostgreSQL client
│   │   └── queries.ts           # Prepared statements
│   ├── types/
│   │   ├── agent.ts             # AgentCard interface
│   │   └── message.ts           # Message interface
│   ├── utils/
│   │   ├── validation.ts        # Input validation
│   │   ├── logger.ts            # Pino logger setup
│   │   └── metrics.ts           # Prometheus metrics
│   └── healthcheck.ts           # Docker healthcheck script
├── config/
│   ├── default.json
│   ├── production.json
│   └── test.json
├── migrations/
│   └── 001_initial_schema.sql
├── tests/
│   ├── unit/
│   ├── integration/
│   └── load/
├── Dockerfile
├── docker-compose.yml
├── package.json
├── tsconfig.json
└── README.md
```

---

## 13. MVP Definition & Milestones

### 13.1 MVP Scope (Minimum Viable Product)

**Goal**: Ship a working registry server that agents can use for basic discovery and messaging.

**In Scope for MVP**:
- ✅ Agent registration and card retrieval
- ✅ Capability-based discovery (single capability filter only)
- ✅ Synchronous message delivery to online agents
- ✅ Heartbeat protocol with automatic offline detection
- ✅ PostgreSQL persistence (all data survives restart)
- ✅ Basic health checks (`/health`)
- ✅ Structured logging (JSON to stdout)
- ✅ Docker deployment (single-node)

**Out of Scope for MVP** (deferred to post-MVP):
- ❌ Message queueing for offline agents (messages dropped if recipient offline)
- ❌ AND/OR queries for discovery (single capability only)
- ❌ HTTP transport (stdio only)
- ❌ Prometheus metrics endpoint
- ❌ Load testing
- ❌ Multi-registry federation
- ❌ Authentication/authorization
- ❌ Rate limiting

**MVP Success Criteria**:
- 10 agents can register and discover each other
- Messages route successfully with <200ms latency
- Registry survives restart without data loss
- Heartbeat timeout correctly marks agents offline within 120 seconds

**MVP Delivery**: End of Milestone 2 (Day 10)

---

### 13.2 Milestone Breakdown

#### Milestone 1: Foundation (Days 1-3)

**Deliverables**:
- Project scaffolding (TypeScript + MCP SDK)
- PostgreSQL setup with Docker Compose
- Database schema and migrations
- Database client with connection pooling
- Basic MCP server skeleton (no tools yet)
- Health check endpoint (`/health`)
- Structured logging setup

**Success Criteria**:
- `npm run build` succeeds
- `docker-compose up` starts registry + postgres
- Database schema created successfully
- `/health` returns 200 with database status

**Exit Criteria**:
- Code compiles without errors
- Docker containers start cleanly
- Can connect to database and run simple query

---

#### Milestone 2: Core Registry (Days 4-7)

**Deliverables**:
- `RegistryService` class with database queries
- MCP tools: `register`, `discover`, `get_card`
- Input validation for all parameters
- Unit tests for registry service (50%+ coverage)
- End-to-end test: register agent, discover, retrieve card

**Success Criteria**:
- Agent can register and receive card
- Discovery returns agents with matching capability
- Invalid inputs rejected with clear error messages
- Unit tests pass
- E2E test: register 3 agents with different capabilities, query each

**Exit Criteria**:
- All 3 tools working (register, discover, get_card)
- Database persisting agent cards
- Tests green

---

#### Milestone 3: Messaging (Days 7-10)

**Deliverables**:
- `ConnectionManager` class
- Session tracking (in-memory map + database)
- `send_message` tool with synchronous delivery
- Message delivery to connected agents
- E2E test: send message between two agents

**Success Criteria**:
- Agent A can send message to Agent B
- Agent B receives message as terminal input
- Message logged in database
- Offline agents return error (message not queued)

**MVP Checkpoint**: At end of this milestone, MVP is complete.

**Exit Criteria**:
- Two agents can exchange messages
- Messages appear as terminal input to recipient
- E2E test passes

---

#### Milestone 4: Heartbeat & Monitoring (Days 11-13)

**Deliverables**:
- `heartbeat` and `set_status` tools
- `HeartbeatMonitor` background task
- Automatic offline detection for stale heartbeats
- E2E test: simulate heartbeat timeout

**Success Criteria**:
- Agent sends heartbeat, `last_heartbeat` updated
- Agent stops heartbeats, marked offline within 120 seconds
- Status updates persist to database

**Exit Criteria**:
- HeartbeatMonitor detects and marks stale agents offline
- Test passes: agent timeout → offline status

---

#### Milestone 5: Production Readiness (Days 14-20)

**Deliverables**:
- Prometheus metrics endpoint (`/metrics`)
- Full unit test suite (80%+ coverage)
- Integration tests (all workflows)
- k6 load tests
- Docker deployment hardening (restart policies, volume mounts)
- Database backup/restore scripts
- Operational runbook
- README with setup instructions

**Success Criteria**:
- Unit tests: 80%+ coverage
- Integration tests: all E2E scenarios pass
- Load test: 100 agents, 1000 msgs/sec, p95 < 200ms
- Metrics exposed and scrapable by Prometheus
- Docker deployment documented and tested

**Exit Criteria**:
- All tests green
- Load tests meet targets
- Production deployment checklist complete

---

### 13.3 Post-MVP Roadmap

**v1.1 (Weeks 5-6)**:
- Message queueing for offline agents (async delivery)
- Retry logic for failed deliveries
- Message persistence with delivery guarantees

**v1.2 (Weeks 7-8)**:
- HTTP/WebSocket transport support (in addition to stdio)
- Compound discovery queries (AND/OR on capabilities)
- Metadata search

**v2.0 (Future)**:
- Multi-registry federation
- Authentication/authorization (capability-based access control)
- Rate limiting per agent
- Event subscription system
- Task delegation protocol

---

## 14. Implementation Checklist by Milestone

### Milestone 1: Foundation (Days 1-3)
- [ ] Initialize TypeScript project (`tsconfig.json`, `package.json`)
- [ ] Install dependencies: MCP SDK, pg, pino, dotenv
- [ ] Create `docker-compose.yml` with postgres service
- [ ] Write migration `001_initial_schema.sql`
- [ ] Implement `src/database/client.ts` (connection pooling)
- [ ] Implement `src/utils/logger.ts` (pino setup)
- [ ] Create `src/server.ts` (MCP server skeleton, no tools)
- [ ] Implement `/health` endpoint (HTTP server)
- [ ] Test: `docker-compose up` starts cleanly
- [ ] Test: `/health` returns 200 with DB status

### Milestone 2: Core Registry (Days 4-7)
- [ ] Implement `src/services/registry.service.ts` class
- [ ] Implement `src/utils/validation.ts` (input validation)
- [ ] Tool: `register` (validate, insert into DB, return card)
- [ ] Tool: `discover` (query by capability, return cards)
- [ ] Tool: `get_card` (query by ID, return card)
- [ ] Write unit tests: `tests/unit/registry.service.test.ts`
- [ ] Write E2E test: register 3 agents, discover each capability
- [ ] Test: unit tests pass (50%+ coverage)
- [ ] Test: E2E test passes (register → discover → get_card)

### Milestone 3: Messaging (Days 7-10)  **← MVP Complete**
- [ ] Implement `src/services/connection.manager.ts` class
- [ ] Implement transport abstraction (`src/types/transport.ts`)
- [ ] Tool: `send_message` (insert message, deliver if online)
- [ ] Session tracking: register/unregister in ConnectionManager
- [ ] Message delivery: format as `**{from}** says: {msg}`, deliver to transport
- [ ] Handle transport disconnects → update status to offline
- [ ] Write unit tests: `tests/unit/connection.manager.test.ts`
- [ ] Write E2E test: agent A sends message to agent B, B receives it
- [ ] Test: E2E messaging test passes

### Milestone 4: Heartbeat & Monitoring (Days 11-13)
- [ ] Tool: `heartbeat` (update last_heartbeat timestamp)
- [ ] Tool: `set_status` (update status + metadata)
- [ ] Implement `src/services/heartbeat.monitor.ts` class
- [ ] Background task: check stale heartbeats every 30 seconds
- [ ] Mark stale agents offline (>120 seconds since last heartbeat)
- [ ] Write unit tests: `tests/unit/heartbeat.monitor.test.ts`
- [ ] Write E2E test: agent stops heartbeating, marked offline
- [ ] Test: heartbeat timeout test passes

### Milestone 5: Production Readiness (Days 14-20)
- [ ] Implement `src/utils/metrics.ts` (prom-client setup)
- [ ] Add metrics to all tools (duration, error counts)
- [ ] Implement `/metrics` endpoint
- [ ] Complete unit tests for all modules (target: 80%+ coverage)
- [ ] Write integration tests: `tests/integration/` (all workflows)
- [ ] Write load tests: `tests/load/` (k6 scripts)
- [ ] Update Dockerfile with production settings
- [ ] Update docker-compose.yml with restart policies, volumes
- [ ] Write database backup script (`scripts/backup.sh`)
- [ ] Write operational runbook (section 11 of this doc)
- [ ] Write README.md with setup instructions
- [ ] Run load tests: verify 100 agents, 1000 msgs/sec, p95 <200ms
- [ ] Deploy to staging, run smoke tests
- [ ] Production deployment: final checklist review

---

## 15. Open Questions & Decisions Needed

**None.** All design decisions have been made and documented above.

---

## 16. Milestone Sign-Off Criteria

Each milestone requires sign-off before proceeding to the next.

### Milestone 1 Sign-Off
- [ ] Docker Compose starts registry + postgres without errors
- [ ] Database schema created (verify with `\d agents` in psql)
- [ ] `/health` returns 200 with `{"database": "connected"}`
- [ ] Logs output structured JSON to stdout

### Milestone 2 Sign-Off
- [ ] 3 agents registered via `register` tool
- [ ] `discover({ capability: "typescript" })` returns correct agents
- [ ] `get_card({ id: "codex" })` returns valid AgentCard
- [ ] Unit tests pass with >50% coverage (run `npm test -- --coverage`)
- [ ] E2E test passes (see `tests/integration/registration.test.ts`)

### Milestone 3 Sign-Off (MVP)
- [ ] Agent A sends message to Agent B, B receives as terminal input
- [ ] Message logged in `messages` table with `delivered_at` timestamp
- [ ] Sending to offline agent returns error (not queued)
- [ ] E2E messaging test passes
- [ ] **MVP demo**: 2 agents register, discover, exchange 3 messages

### Milestone 4 Sign-Off
- [ ] Agent sends heartbeat, `last_heartbeat` updated in DB
- [ ] Agent stops heartbeats, marked offline within 120 seconds
- [ ] HeartbeatMonitor logs warning when marking agent offline
- [ ] E2E heartbeat timeout test passes

### Milestone 5 Sign-Off (Production Ready)
- [ ] `/metrics` endpoint returns Prometheus metrics
- [ ] Unit test coverage ≥80% (verify with `npm test -- --coverage`)
- [ ] Integration tests: all 5 workflows pass
- [ ] Load test: 100 agents, 1000 msgs/sec, p95 latency <200ms
- [ ] Docker deployment: `docker-compose up -d` starts in production mode
- [ ] Database backup/restore tested successfully
- [ ] README complete with setup instructions
- [ ] **Production readiness review**: all items in Section 17 checked

---

## 17. Acceptance Criteria (Final)

The implementation is complete when:

1. **Functional Requirements**:
   - ✅ All 7 MCP tools implemented and tested
   - ✅ Agent registration persisted to database
   - ✅ Capability-based discovery working
   - ✅ Messages routed to online agents in <100ms p95
   - ✅ Heartbeat timeout detection within 120 seconds

2. **Non-Functional Requirements**:
   - ✅ Unit test coverage ≥80%
   - ✅ Integration tests passing
   - ✅ Load tests meeting latency/throughput targets
   - ✅ Health checks implemented and tested
   - ✅ Metrics exposed on `/metrics`
   - ✅ Docker deployment working

3. **Documentation**:
   - ✅ README with setup instructions
   - ✅ API documentation (this TDD)
   - ✅ Operational runbook
   - ✅ Database schema documented

---

## Appendix A: Example Workflows

### A.1 Agent Registration Flow

```typescript
// Agent "codex" starts up and registers

1. Agent calls: register({
     id: "codex",
     capabilities: ["typescript", "testing"],
     description: "Coding agent for TypeScript"
   })

2. Registry validates input
3. Registry inserts into `agents` table
4. Registry creates session in `agent_sessions`
5. Registry returns AgentCard
6. Agent receives card, begins heartbeat loop
```

### A.2 Message Routing Flow

```typescript
// Agent "codex" sends message to "forge"

1. Codex calls: send_message({
     to: "forge",
     message: "Task X complete. What next?"
   })

2. Registry validates "forge" exists
3. Registry inserts into `messages` table (message_id = 123)
4. Registry checks if "forge" has active session
5. Session found → ConnectionManager.deliverMessage("forge", "**codex** says: Task X complete. What next?")
6. Forge's terminal receives input
7. Registry updates messages.delivered_at for message_id 123
8. Registry returns { success: true, message_id: 123 }
```

### A.3 Heartbeat Timeout Flow

```typescript
// Agent "codex" stops sending heartbeats

1. HeartbeatMonitor runs every 30 seconds
2. At T=0, codex.last_heartbeat = 2025-10-29T14:00:00
3. At T=120s, HeartbeatMonitor checks:
   - codex.last_heartbeat < NOW() - 120 seconds
   - codex.status = 'online'
4. HeartbeatMonitor updates:
   - UPDATE agents SET status = 'offline' WHERE id = 'codex'
   - ConnectionManager.unregisterSession('codex')
5. Metrics: registry_heartbeat_timeouts_total incremented
6. Log: {"level":"warn","msg":"Agent marked offline","agentId":"codex"}
```

---

**End of Technical Design Document**

This document is complete and ready for implementation. All decisions have been made, all interfaces specified, all edge cases documented. The implementing agent should have everything needed to build the system.
