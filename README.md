# Claude Code Environment

Personal Claude Code configuration including CLAUDE.md instructions, custom skills, agents, and plugin settings.

## Structure

```
claude-environment/
├── CLAUDE.md                # Workflow rules and core principles
├── settings.json            # Plugins, hooks, model, env vars
├── settings.local.json      # Permissions (not committed — create your own)
├── skills/                  # 16 skill modules
│   ├── accessibility-audit/
│   ├── baseline-ui/
│   ├── design-system-patterns/
│   ├── documentation-templates/
│   ├── figma/
│   ├── find-skills/
│   ├── fixing-accessibility/
│   ├── fixing-metadata/
│   ├── fixing-motion-performance/
│   ├── frontend-design/
│   ├── mark-jenkins/
│   ├── mo-modals-mo-problems/
│   ├── parallel-debugging/
│   ├── parallel-feature-development/
│   ├── ui-ux-pro-max/
│   └── ux-microcopy-audit/
└── agents/                  # 14 custom agents
    ├── code-improvement-agent.md
    ├── content-improvement-agent.md
    ├── gsd-codebase-mapper.md
    ├── gsd-debugger.md
    ├── gsd-executor.md
    ├── gsd-integration-checker.md
    ├── gsd-phase-researcher.md
    ├── gsd-plan-checker.md
    ├── gsd-planner.md
    ├── gsd-project-researcher.md
    ├── gsd-research-synthesizer.md
    ├── gsd-roadmapper.md
    ├── gsd-verifier.md
    └── ux-ui-improvement-reviewer.md
```

## What's Included

### CLAUDE.md
Workflow rules for Claude Code sessions: plan-first approach, subagent strategy, self-improvement loops, verification before done, and core principles (simplicity, no lazy fixes, minimal impact).

### Settings
- **settings.json** — Model set to Opus, agent teams enabled, GSD hooks for session start and post-tool-use, 13 enabled plugins
- **settings.local.json** — Not committed. Create this file in `~/.claude/` with your own machine-specific permissions (Bash, WebFetch, MCP allowances, etc.)

> **Note:** `settings.json` references hook scripts (`hooks/gsd-check-update.js`, `hooks/sync-environment.sh`, `hooks/gsd-context-monitor.js`, `hooks/gsd-statusline.js`) that are not included in this repo. These are optional — remove or replace the hooks entries if you don't have them.

### Skills (16)

| Category | Skills |
|----------|--------|
| **Accessibility** | accessibility-audit, fixing-accessibility |
| **Design & UI** | baseline-ui, design-system-patterns, figma, frontend-design, mo-modals-mo-problems, ui-ux-pro-max |
| **Content & Docs** | documentation-templates, fixing-metadata, ux-microcopy-audit |
| **Performance** | fixing-motion-performance |
| **Agent Teams** | parallel-debugging, parallel-feature-development |
| **Utility** | find-skills, mark-jenkins |

### Agents (14)

| Category | Agents |
|----------|--------|
| **Code Quality** | code-improvement-agent, content-improvement-agent, ux-ui-improvement-reviewer |
| **GSD Workflow** | gsd-planner, gsd-executor, gsd-verifier, gsd-debugger, gsd-roadmapper, gsd-codebase-mapper, gsd-phase-researcher, gsd-plan-checker, gsd-project-researcher, gsd-research-synthesizer, gsd-integration-checker |

## Installation

```bash
# Clone into your .claude directory
git clone https://github.com/markj81/claude-environment.git ~/.claude

# Or cherry-pick what you need:
cp CLAUDE.md ~/.claude/
cp settings.json ~/.claude/
cp -r skills/ ~/.claude/
cp -r agents/ ~/.claude/
```

After cloning, create `~/.claude/settings.local.json` with your own machine-specific permissions.

If you don't have the GSD hook scripts, remove or comment out the `hooks` and `statusLine` entries in `settings.json`.

## Plugins

This config enables these Claude Code plugins:

- frontend-design (official)
- accessibility-compliance, agent-orchestration, agent-teams
- backend-api-security, code-documentation, code-refactoring
- code-review-ai, codebase-cleanup, frontend-mobile-development
- full-stack-orchestration, ui-design, seo-analysis-monitoring

## License

MIT
