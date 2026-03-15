# Claude Code Environment

Personal Claude Code configuration including CLAUDE.md instructions, custom skills, agents, and plugin settings.

## Structure

```
claude-environment/
├── CLAUDE.md                # Workflow rules and core principles
├── settings.json            # Plugins, hooks, model, env vars
├── settings.local.json      # Permissions template (customize per machine)
├── skills/                  # 33 skill modules
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
│   ├── performance-engineer/
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
└── agents/                  # 24 custom agents
    ├── accessibility-expert.md
    ├── code-improvement-agent.md
    ├── code-reviewer.md
    ├── content-improvement-agent.md
    ├── deployment-engineer.md
    ├── frontend-developer.md
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
    ├── security-auditor.md
    ├── team-debugger.md
    ├── team-implementer.md
    ├── team-lead.md
    ├── team-reviewer.md
    ├── test-automator.md
    └── ux-ui-improvement-reviewer.md
```

## What's Included

### CLAUDE.md
Workflow rules for Claude Code sessions: plan-first approach, subagent strategy, self-improvement loops, verification before done, and core principles (simplicity, no lazy fixes, minimal impact).

### Settings
- **settings.json** - Model set to Opus, agent teams enabled, GSD hooks for session start and post-tool-use, 13 enabled plugins
- **settings.local.json** - Permission template with Figma MCP, Bash, WebFetch, and git allowances (customize with your own domains)

### Skills (33)

| Category | Skills |
|----------|--------|
| **Accessibility** | accessibility-audit, accessibility-compliance, fixing-accessibility, wcag-audit-patterns |
| **Design & UI** | baseline-ui, design-system-patterns, figma, frontend-design, interaction-design, mo-modals-mo-problems, ui-ux-pro-max, visual-design-foundations |
| **Mobile** | mobile-android-design, mobile-ios-design, react-native-architecture |
| **Frontend** | nextjs-app-router-patterns, react-state-management, responsive-design, tailwind-design-system, web-component-design |
| **Content & Docs** | documentation-templates, fixing-metadata, ux-microcopy-audit |
| **Performance** | fixing-motion-performance, performance-engineer |
| **Agent Teams** | multi-reviewer-patterns, parallel-debugging, parallel-feature-development, task-coordination-strategies, team-communication-protocols, team-composition-patterns |
| **Utility** | find-skills, mark-jenkins |

### Agents (24)

| Category | Agents |
|----------|--------|
| **Code Quality** | code-improvement-agent, code-reviewer, content-improvement-agent, ux-ui-improvement-reviewer |
| **Architecture** | frontend-developer, deployment-engineer, security-auditor, accessibility-expert, test-automator |
| **GSD Workflow** | gsd-planner, gsd-executor, gsd-verifier, gsd-debugger, gsd-roadmapper, gsd-codebase-mapper, gsd-phase-researcher, gsd-plan-checker, gsd-project-researcher, gsd-research-synthesizer, gsd-integration-checker |
| **Agent Teams** | team-lead, team-implementer, team-debugger, team-reviewer |

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

After cloning, edit `settings.local.json` with your own domains and paths.

## Plugins

This config enables these Claude Code plugins:

- frontend-design (official)
- accessibility-compliance, agent-orchestration, agent-teams
- backend-api-security, code-documentation, code-refactoring
- code-review-ai, codebase-cleanup, frontend-mobile-development
- full-stack-orchestration, ui-design, seo-analysis-monitoring

## License

MIT
