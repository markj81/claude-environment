# Claude Code Environment

A shareable Claude Code configuration with workflow rules, 32 skills, 37 agents, and plugin settings. Drop it into `~/.claude/` to get a fully-configured environment for AI-assisted development.

**What you get:**
- Opinionated workflow rules (plan-first, verify before done, autonomous bug fixing)
- Skills for UI/UX, accessibility, mobile, frontend, agent teams, and more
- Agents for code quality, architecture, GSD workflow, and multi-agent team coordination
- Hook scripts including auto-sync and GSD integration
- 13 Claude Code plugins pre-enabled

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and authenticated
- Node.js (for hook scripts)
- Optional: [GSD](https://www.npmjs.com/package/get-shit-done-cc) for the planning/execution workflow (`npm install -g get-shit-done-cc`)

## Installation

> **Warning:** Cloning into `~/.claude/` will overwrite any existing Claude Code config. Back up your existing `~/.claude/` first, or cherry-pick only what you need (see below).

```bash
# Back up existing config (optional but recommended)
cp -r ~/.claude/ ~/.claude.bak/

# Clone into your .claude directory
git clone https://github.com/markj81/claude-environment.git ~/.claude
```

Then create `~/.claude/settings.local.json` with your machine-specific permissions:

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(npm:*)",
      "WebFetch(domain:*)"
    ]
  }
}
```

If you're not using GSD, remove the `hooks` and `statusLine` entries from `settings.json`.

## Structure

```
~/.claude/
├── CLAUDE.md              # Workflow rules loaded into every session
├── settings.json          # Model, plugins, hooks, env vars
├── settings.local.json    # Your machine-specific permissions (not committed)
├── hooks/                 # Session hooks (GSD integration + auto-sync)
├── skills/                # 32 slash-command skills
└── agents/                # 37 subagent definitions
```

## CLAUDE.md — Workflow Rules

Loaded automatically into every Claude Code session. Key principles:

- **Plan mode default** — enter plan mode for any non-trivial task
- **Subagent strategy** — offload research and parallel work to subagents
- **Self-improvement loop** — update `tasks/lessons.md` after every correction
- **Verify before done** — never mark complete without proving it works
- **Autonomous bug fixing** — fix bugs directly from logs and errors, no hand-holding

## Skills (32)

Invoked with `/skill-name` in any Claude Code session.

| Category | Skills |
|----------|--------|
| **Accessibility** | accessibility-audit, accessibility-compliance, fixing-accessibility, wcag-audit-patterns |
| **Design & UI** | baseline-ui, design-system-patterns, figma, frontend-design, interaction-design, mo-modals-mo-problems, ui-ux-pro-max, visual-design-foundations |
| **Mobile** | mobile-android-design, mobile-ios-design, react-native-architecture |
| **Frontend** | nextjs-app-router-patterns, react-state-management, responsive-design, tailwind-design-system, web-component-design |
| **Content & Docs** | documentation-templates, fixing-metadata, ux-microcopy-audit |
| **Performance** | fixing-motion-performance |
| **Agent Teams** | multi-reviewer-patterns, parallel-debugging, parallel-feature-development, task-coordination-strategies, team-communication-protocols, team-composition-patterns |
| **Utility** | find-skills, mark-jenkins |

## Agents (37)

Custom subagents Claude can spawn to handle specialized tasks.

| Category | Agents |
|----------|--------|
| **Code Quality** | code-improvement-agent, code-reviewer, content-improvement-agent, ux-ui-improvement-reviewer |
| **Architecture** | backend-architect, backend-security-coder, deployment-engineer, docs-architect, frontend-developer, legacy-modernizer, performance-engineer, security-auditor |
| **Design** | accessibility-expert, design-system-architect, ui-designer, ui-visual-validator |
| **SEO** | seo-authority-builder, seo-cannibalization-detector, seo-content-refresher |
| **Testing** | fullstack-test-automator, test-automator |
| **GSD Workflow** | gsd-planner, gsd-executor, gsd-verifier, gsd-debugger, gsd-roadmapper, gsd-codebase-mapper, gsd-phase-researcher, gsd-plan-checker, gsd-project-researcher, gsd-research-synthesizer, gsd-integration-checker |
| **Agent Teams** | context-manager, team-lead, team-implementer, team-debugger, team-reviewer |

### GSD Workflow Agents

GSD ("Get Shit Done") is a structured planning and execution workflow (`npm install -g get-shit-done-cc`). The 11 GSD agents handle the full cycle: roadmap → research → plan → execute → verify → debug. They are invoked automatically by GSD slash commands — you don't call them directly.

## Hooks

Four hook scripts in `hooks/` wire Claude Code sessions to GSD and keep the repo in sync:

| Hook | Trigger | Purpose |
|------|---------|---------|
| `sync-environment.sh` | SessionStart | Auto-commits and pushes any local changes to this repo |
| `gsd-check-update.js` | SessionStart | Checks npm for a newer GSD version in the background |
| `gsd-context-monitor.js` | PostToolUse | Monitors context window usage for GSD state management |
| `gsd-statusline.js` | StatusLine | Shows GSD project/phase info in the Claude Code status bar |

The auto-sync hook (`sync-environment.sh`) is what keeps the repo up to date automatically — it runs silently on session start and only commits if something changed. If you fork this repo, update the `REMOTE` variable in that file to point to your fork.

## Plugins (13)

Enabled in `settings.json` via `enabledPlugins`:

| Plugin | Source |
|--------|--------|
| frontend-design | claude-plugins-official |
| accessibility-compliance, agent-orchestration, agent-teams | claude-code-workflows |
| backend-api-security, code-documentation, code-refactoring | claude-code-workflows |
| code-review-ai, codebase-cleanup, frontend-mobile-development | claude-code-workflows |
| full-stack-orchestration, ui-design, seo-analysis-monitoring | claude-code-workflows |

## Cherry-picking

You don't have to use everything. Copy only what you need:

```bash
# Just the workflow rules
cp CLAUDE.md ~/.claude/

# Just the skills
cp -r skills/ ~/.claude/skills/

# Just the agents
cp -r agents/ ~/.claude/agents/

# Just the settings
cp settings.json ~/.claude/
```

## License

MIT
