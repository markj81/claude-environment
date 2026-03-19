# Claude Code Environment

Personal Claude Code configuration including CLAUDE.md instructions, custom skills, agents, and plugin settings.

## Structure

```
claude-environment/
├── CLAUDE.md                # Workflow rules and core principles
├── settings.json            # Plugins, hooks, model, env vars
├── settings.local.json      # Permissions (not committed — create your own)
├── skills/                  # 32 skill modules
│   ├── accessibility-audit/
│   ├── accessibility-compliance/
│   ├── baseline-ui/
│   ├── design-system-patterns/
│   ├── documentation-templates/
│   ├── figma/
│   ├── find-skills/
│   ├── fixing-accessibility/
│   ├── fixing-metadata/
│   ├── fixing-motion-performance/
│   ├── frontend-design/
│   ├── interaction-design/
│   ├── mark-jenkins/
│   ├── mo-modals-mo-problems/
│   ├── mobile-android-design/
│   ├── mobile-ios-design/
│   ├── multi-reviewer-patterns/
│   ├── nextjs-app-router-patterns/
│   ├── parallel-debugging/
│   ├── parallel-feature-development/
│   ├── react-native-architecture/
│   ├── react-state-management/
│   ├── responsive-design/
│   ├── tailwind-design-system/
│   ├── task-coordination-strategies/
│   ├── team-communication-protocols/
│   ├── team-composition-patterns/
│   ├── ui-ux-pro-max/
│   ├── ux-microcopy-audit/
│   ├── visual-design-foundations/
│   ├── wcag-audit-patterns/
│   └── web-component-design/
└── agents/                  # 37 custom agents
    ├── accessibility-expert.md
    ├── backend-architect.md
    ├── backend-security-coder.md
    ├── code-improvement-agent.md
    ├── code-reviewer.md
    ├── content-improvement-agent.md
    ├── context-manager.md
    ├── deployment-engineer.md
    ├── design-system-architect.md
    ├── docs-architect.md
    ├── frontend-developer.md
    ├── fullstack-test-automator.md
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
    ├── legacy-modernizer.md
    ├── performance-engineer.md
    ├── security-auditor.md
    ├── seo-authority-builder.md
    ├── seo-cannibalization-detector.md
    ├── seo-content-refresher.md
    ├── team-debugger.md
    ├── team-implementer.md
    ├── team-lead.md
    ├── team-reviewer.md
    ├── test-automator.md
    ├── ui-designer.md
    ├── ui-visual-validator.md
    └── ux-ui-improvement-reviewer.md
```

## What's Included

### CLAUDE.md
Workflow rules for Claude Code sessions: plan-first approach, subagent strategy, self-improvement loops, verification before done, and core principles (simplicity, no lazy fixes, minimal impact).

### Settings
- **settings.json** — Model set to Opus, agent teams enabled, GSD hooks for session start and post-tool-use, 13 enabled plugins
- **settings.local.json** — Not committed. Create this file in `~/.claude/` with your own machine-specific permissions (Bash, WebFetch, MCP allowances, etc.)

> **Note:** `settings.json` references hook scripts (`hooks/gsd-check-update.js`, `hooks/sync-environment.sh`, `hooks/gsd-context-monitor.js`, `hooks/gsd-statusline.js`) that are not included in this repo. These are optional — remove or replace the hooks entries if you don't have them.

### Skills (32)

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

### Agents (37)

| Category | Agents |
|----------|--------|
| **Code Quality** | code-improvement-agent, code-reviewer, content-improvement-agent, ux-ui-improvement-reviewer |
| **Architecture** | backend-architect, backend-security-coder, deployment-engineer, docs-architect, frontend-developer, legacy-modernizer, performance-engineer, security-auditor |
| **Design** | accessibility-expert, design-system-architect, ui-designer, ui-visual-validator |
| **SEO** | seo-authority-builder, seo-cannibalization-detector, seo-content-refresher |
| **Testing** | fullstack-test-automator, test-automator |
| **GSD Workflow** | gsd-planner, gsd-executor, gsd-verifier, gsd-debugger, gsd-roadmapper, gsd-codebase-mapper, gsd-phase-researcher, gsd-plan-checker, gsd-project-researcher, gsd-research-synthesizer, gsd-integration-checker |
| **Agent Teams** | context-manager, team-lead, team-implementer, team-debugger, team-reviewer |

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
