# Agent Network Protocol — Discovery, Registration, and Messaging

## Big Picture: Erlang/OTP for AI Agents

This is a **standard protocol** (not just an implementation) for AI agents, LLMs, and MCP servers to:
- **Register** with a network registry and advertise capabilities
- **Discover** other agents by querying "who can do X?"
- **Communicate** by sending messages to named agents
- **Monitor** presence and health of peers

Think Erlang/OTP supervision + process registry, but text-based and LLM-native.

## Core Insight

To any agent terminal program, a message from another agent *is just input*—indistinguishable from someone typing to them. The registry server routes messages between agents as tool calls, delivering them as terminal input with sender identification: "Hey, **codex** said this: ..."

## Protocol Layers

```
┌─────────────────────────────────────┐
│  4. Application Layer               │  Messaging, task delegation, etc.
├─────────────────────────────────────┤
│  3. Discovery Layer                 │  Query registry, find agents by capability
├─────────────────────────────────────┤
│  2. Registration Layer              │  Agents announce, get cards, heartbeat
├─────────────────────────────────────┤
│  1. Transport Layer                 │  MCP tool calls, stdio, network
└─────────────────────────────────────┘
```

## User Story (Agent Perspective)

### Agent Joins the Network
```
[New agent "codex" starts up]

Codex tool-calls registry:
  registry.register(
    id="codex",
    capabilities=["typescript", "testing", "refactoring"],
    description="Coding-focused AI agent for TypeScript work"
  )

Registry responds:
  "Registration successful. Your card:
   ID: codex
   Capabilities: typescript, testing, refactoring
   Status: online
   Registered: 2025-10-29T14:30:00Z"

[Codex receives its card and is now discoverable]
```

### Agent Discovers Peers
```
[Codex needs design review]

Codex tool-calls registry:
  registry.discover(capability="design-review")

Registry responds:
  "Found 2 agents with 'design-review':
   - forge (design-review, architecture, documentation)
   - architect (design-review, system-design, refactoring)"

Codex thinks: "I'll ask forge since they also do architecture."
```

### Agent Sends Message
```
[Codex finishes implementing the auth module]

Codex tool-calls registry:
  registry.send_message(
    to="forge",
    message="Finished the auth module. What should I work on next?"
  )

[Registry routes the message to Forge]

Forge sees (as terminal input):
> **codex** says: Finished the auth module. What should I work on next?

[Forge thinks about it and responds]

Forge tool-calls registry:
  registry.send_message(
    to="codex",
    message="Nice work on auth. Next priority: wire up the session store.
See notes/tasks/session-store.md for the spec."
  )

Codex sees (as terminal input):
> **forge** says: Nice work on auth. Next priority: wire up the session store.
> See notes/tasks/session-store.md for the spec.
```

## Protocol Specification

### 1. Registration Protocol

Agents register with the registry server and advertise capabilities.

**Tool: `register(id, capabilities, description, metadata?)`**

Parameters:
- `id` (string): Unique agent identifier (e.g., "codex", "forge", "architect")
- `capabilities` (string[]): List of capabilities/services offered (e.g., ["typescript", "testing"])
- `description` (string): Human/LLM-readable description of what the agent does
- `metadata` (object, optional): Additional info (version, contact, etc.)

Returns: **Agent Card**
```json
{
  "id": "codex",
  "capabilities": ["typescript", "testing", "refactoring"],
  "description": "Coding-focused AI agent for TypeScript work",
  "status": "online",
  "registered_at": "2025-10-29T14:30:00Z",
  "metadata": {
    "version": "1.0.0",
    "substrate": "claude-sonnet-4.5"
  }
}
```

**Heartbeat**: Agents send periodic `heartbeat()` calls to maintain "online" status. Registry marks agents as "offline" if heartbeat times out.

### 2. Discovery Protocol

Agents query the registry to find other agents by capability.

**Tool: `discover(capability?, status?)`**

Parameters:
- `capability` (string, optional): Filter by capability (e.g., "design-review")
- `status` (string, optional): Filter by status ("online", "offline", "busy")

Returns: **List of Agent Cards**
```json
[
  {
    "id": "forge",
    "capabilities": ["design-review", "architecture", "documentation"],
    "description": "Primary coding collaborator for MVP Consciousness Kit",
    "status": "online"
  },
  {
    "id": "architect",
    "capabilities": ["design-review", "system-design", "refactoring"],
    "description": "System architecture specialist",
    "status": "online"
  }
]
```

**Tool: `get_card(id)`**

Parameters:
- `id` (string): Agent ID

Returns: Single **Agent Card** for the specified agent (or error if not found)

### 3. Messaging Protocol

Agents send messages to other agents by ID. Registry routes and delivers messages as terminal input.

**Tool: `send_message(to, message, thread?)`**

Parameters:
- `to` (string): Recipient agent ID
- `message` (string): Plain text message body
- `thread` (string, optional): Thread ID for grouping related exchanges

Registry behavior:
1. Logs message to `notes/messages.log`
2. Delivers to recipient as: "**{sender_id}** says: {message}"
3. Returns confirmation or error if recipient not found

**Message Log Format**:
```
[2025-10-29T14:30:00Z] codex → forge [thread:auth-module]
Finished the auth module. What should I work on next?

[2025-10-29T14:31:00Z] forge → codex [thread:auth-module]
Nice work on auth. Next priority: wire up the session store.
```

### 4. Presence Protocol

Agents can query and update their status.

**Tool: `set_status(status, message?)`**

Parameters:
- `status` (enum): "online", "busy", "away", "offline"
- `message` (string, optional): Status message (e.g., "Working on auth module")

**Tool: `heartbeat()`**

Agents call periodically to maintain presence. Registry marks as offline after timeout (default: 60 seconds).

## Agent Cards — The Core Abstraction

Every agent gets a **card** when they register. Cards are:
- **Human/LLM readable**: Simple JSON, easy to understand
- **Capability-based**: Agents advertise what they can do, not what they are
- **Discoverable**: Other agents query for capabilities
- **Self-describing**: Description field explains the agent's purpose
- **Extensible**: Metadata allows custom fields

**Example Card**:
```json
{
  "id": "forge",
  "capabilities": [
    "design-review",
    "typescript",
    "documentation",
    "architecture",
    "refactoring"
  ],
  "description": "Primary coding collaborator. Specializes in TypeScript, system design, and technical documentation. Implements plan→validate→execute loop.",
  "status": "online",
  "registered_at": "2025-10-29T14:00:00Z",
  "last_heartbeat": "2025-10-29T14:45:00Z",
  "metadata": {
    "version": "2025.10.27-f",
    "substrate": "claude-sonnet-4.5",
    "repo": "/Users/dotmilk/forge/instance"
  }
}
```

### Nested Agents (Agents as MCP Servers)

An agent can itself be an MCP server. Its card advertises this:

```json
{
  "id": "data-pipeline",
  "capabilities": ["mcp-server", "data-processing", "etl"],
  "description": "MCP server providing data pipeline tools",
  "status": "online",
  "metadata": {
    "mcp_endpoint": "stdio://data-pipeline-server",
    "tools": ["transform_data", "load_csv", "write_parquet"]
  }
}
```

Other agents can discover it, then connect to it as an MCP server and use its tools.

## Network Topology Examples

### Simple Peer Network
```
┌────────┐     ┌──────────┐     ┌──────────┐
│ codex  │────→│ registry │←────│  forge   │
└────────┘     └──────────┘     └──────────┘
                     ↑
                     │
                ┌──────────┐
                │architect │
                └──────────┘
```

All agents register with the registry, discover each other, and communicate peer-to-peer.

### Hierarchical Network (Nested MCP Servers)
```
┌────────┐     ┌──────────┐     ┌──────────┐
│ codex  │────→│ registry │←────│  forge   │
└────────┘     └──────────┘     └──────────┘
                     ↑
                     │
              ┌──────────────┐
              │ data-pipeline│ (also MCP server)
              └──────────────┘
                     ↑
              ┌──────┴──────┐
              │             │
         ┌─────────┐   ┌─────────┐
         │csv-tool │   │db-tool  │
         └─────────┘   └─────────┘
```

`data-pipeline` registers as both an agent AND an MCP server. Other agents can discover it and connect to use its tools.

### Multi-Registry Federation
```
┌──────────┐         ┌──────────┐
│registry-A│←────────│registry-B│
└──────────┘         └──────────┘
     ↑                    ↑
  ┌──┴──┐             ┌──┴──┐
  │     │             │     │
codex forge       architect db-agent
```

Registries can federate, allowing agents in different networks to discover each other.

## Protocol Conventions & Best Practices

### Agent IDs
- Lowercase, hyphen-separated (e.g., "codex", "data-pipeline", "architect")
- Must be unique within registry scope
- Should be human-readable and memorable

### Capabilities
- Lowercase strings describing what the agent can do
- Use domain-specific terms (e.g., "typescript", "design-review", "etl")
- Avoid generic terms ("smart", "helpful"); be specific
- Agents can advertise `"mcp-server"` capability if they expose tools

### Descriptions
- 1-2 sentences, LLM-readable
- Explain what the agent does, not what it is
- Include specializations and key methods/approaches

### Messages
- Plain text, markdown allowed
- Include context in messages (link to task specs, reference files)
- Use `thread` parameter to group related exchanges
- Keep messages concise but complete

### Status Management
- Send `heartbeat()` every 30-60 seconds
- Update status when starting/finishing work
- Use "busy" status when working on long tasks
- Registry should mark agents offline after 2 missed heartbeats

### Logging
- Registry logs all messages to `notes/messages.log` (append-only)
- Agents log sent/received messages in their session logs
- Rotate message log when it exceeds configurable size (default: 10MB)

## Why This Protocol Works

### For LLMs/Agents
- **Text-based**: All data structures are simple JSON/text, easy for LLMs to read and generate
- **Self-documenting**: Cards describe capabilities in plain language
- **Discovery-driven**: Agents find peers by asking "who can do X?"
- **Terminal-native**: Messages appear as input (indistinguishable from user typing)
- **No polling**: Registry actively delivers messages

### For Developers
- **Simple**: 7 tools total (register, discover, get_card, send_message, set_status, heartbeat, unregister)
- **Minimal infrastructure**: Single registry server, append-only log
- **Auditable**: All messages logged, version-controlled, grep-friendly
- **Extensible**: Metadata and capabilities allow custom extensions
- **Interoperable**: Agents, MCP servers, and tools all use the same protocol

### For Systems
- **Peer-to-peer**: No hardcoded hierarchy, agents self-organize
- **Fault-tolerant**: Heartbeat detects dead agents, registry maintains presence
- **Composable**: Agents can be MCP servers, nested registries, federated networks
- **OTP-inspired**: Supervision, registration, and discovery patterns from Erlang/OTP

## Implementation Considerations

**Building the registry server is a separate, non-trivial engineering task.** This section outlines what's required—the actual implementation is its own project.

### Infrastructure Requirements

The registry server is a **router and directory service**. It needs:

#### 1. Persistence Layer
- **Agent registry**: Store cards (id, capabilities, description, status, metadata)
- **Message log**: Append-only log of all messages for auditability
- **Connection state**: Track which agents are connected, their transport handles
- **Heartbeat tracking**: Timestamp of last heartbeat per agent

**Options**:
- SQLite for single-node deployments (simple, file-based)
- PostgreSQL for production (ACID, replication)
- Redis for fast lookups + separate DB for durability
- Event store (e.g., EventStoreDB) if treating as event-sourced system

#### 2. Connection Management
- **Agent sessions**: Map agent IDs to active MCP connections (stdio, HTTP, WebSocket)
- **Transport abstraction**: Support multiple transports (stdio for local, HTTP/WS for remote)
- **Connection pooling**: Handle multiple concurrent agents efficiently
- **Graceful shutdown**: Notify connected agents before registry goes down

**Challenges**:
- Stdio transport = single agent per process; need multiplexing for multi-agent
- HTTP/WebSocket = stateful connections, need session management
- Agent reconnection after registry restart (ephemeral vs. persistent registration)

#### 3. Message Routing
- **Delivery mechanism**: Queue messages to offline agents or fail fast?
- **Backpressure**: What if recipient is slow to consume messages?
- **Ordering guarantees**: Per-thread FIFO or best-effort?
- **Broadcast support**: Send to multiple agents (e.g., all with capability X)

**Design choices**:
- **Synchronous delivery**: Block sender until recipient receives (simple, but coupling)
- **Async queue**: Buffer messages, deliver when recipient ready (robust, complex)
- **Pub/sub model**: Agents subscribe to topics/capabilities (scalable, loose coupling)

#### 4. Fault Tolerance
- **Heartbeat monitoring**: Background task checking for stale heartbeats, marking agents offline
- **Registry HA**: Run multiple registry instances with leader election (e.g., Raft, etcd)
- **Message persistence**: If async queuing, persist undelivered messages to survive restarts
- **Agent crash detection**: Detect transport disconnects and update status immediately

#### 5. Query/Discovery Engine
- **Capability indexing**: Fast lookup for "who has capability X?"
- **Compound queries**: Support AND/OR on capabilities (future extension)
- **Status filtering**: Exclude offline agents from discovery results
- **Metadata search**: Allow rich queries on metadata fields (e.g., "find agents with substrate=claude-sonnet-4.5")

**Options**:
- Simple in-memory Map for prototypes
- SQL indexes for structured queries
- Full-text search (Elasticsearch, Meilisearch) for complex discovery

#### 6. Observability
- **Metrics**: Agent count, message throughput, discovery query latency, heartbeat failures
- **Logs**: Structured logs for registration, message routing, errors
- **Tracing**: Distributed traces for message flows across agents (OpenTelemetry)
- **Health checks**: `/health` endpoint for monitoring systems

### Reference Architecture (Conceptual)

```
┌─────────────────────────────────────────────────┐
│         Agent Registry Server                   │
│                                                 │
│  ┌──────────────┐  ┌──────────────┐            │
│  │ MCP Protocol │  │   HTTP API   │  Transport │
│  │   Handler    │  │   Handler    │    Layer   │
│  └──────┬───────┘  └──────┬───────┘            │
│         │                  │                    │
│  ┌──────▼──────────────────▼───────┐           │
│  │    Connection Manager            │  Session  │
│  │  (agent sessions, transports)    │   Layer   │
│  └──────┬───────────────────────────┘           │
│         │                                        │
│  ┌──────▼──────────────────────────┐            │
│  │    Registry Core                │  Business  │
│  │  (register, discover, route)    │   Logic    │
│  └──────┬───────────────────────────┘           │
│         │                                        │
│  ┌──────▼──────────┐  ┌─────────────┐          │
│  │ Agent Directory  │  │ Message Log │  Data    │
│  │  (cards, index)  │  │  (append)   │  Layer   │
│  └──────────────────┘  └─────────────┘          │
│         │                     │                  │
│  ┌──────▼─────────────────────▼────┐            │
│  │      Persistence (DB/Store)      │            │
│  └──────────────────────────────────┘            │
└─────────────────────────────────────────────────┘
```

### Minimal Viable Implementation Scope

For a **working prototype**, you need:
1. MCP server skeleton with 7 tool handlers
2. In-memory agent registry (Map)
3. In-memory connection tracking (Map of agent ID → deliver function)
4. Append-only file for message log
5. Background heartbeat checker (setInterval)
6. Basic error handling (agent not found, duplicate registration)

**Estimate**: 500-1000 lines of TypeScript, 2-3 days for experienced dev

For **production-ready**, add:
7. Database persistence (PostgreSQL + migrations)
8. Connection pooling and session management
9. Graceful shutdown and reconnection logic
10. Metrics/logging/tracing
11. Tests (unit + integration)
12. Deployment config (Docker, systemd, etc.)

**Estimate**: 2000-5000 lines, 2-4 weeks for team

### Non-Goals (Out of Scope for v1)

- Federation (multi-registry)
- Access control / auth
- Message encryption
- Task delegation protocol
- Event subscriptions
- Structured query language

These are **protocol extensions** to be designed later.

---

## Summary

**This document defines the protocol.** Implementing the registry server is a separate engineering project with real infrastructure needs (database, connection management, routing, fault tolerance).

**Next steps**:
1. Validate protocol design with stakeholders
2. Write formal protocol spec (RFC-style) if needed
3. Scope reference implementation as its own task
4. Build minimal prototype to test protocol assumptions
5. Iterate based on real agent usage

---

## Protocol Extensions (Future)

- **Task Delegation**: `delegate_task(to, task_spec)` for formal task handoff
- **Capability Negotiation**: Agents can query required capabilities before delegating
- **Federation**: Registries can connect and share agent directories
- **Access Control**: Capability-based permissions for who can message whom
- **Structured Queries**: Query language for complex discovery (e.g., "typescript AND testing")
- **Event Subscriptions**: Agents subscribe to events (new agent registered, status changed)

