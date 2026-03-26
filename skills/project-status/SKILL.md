---
name: project-status
description: >
  Quick health check across all projects in the working directory. Checks build status, dependency health,
  git state, and environment configuration. Use when starting a session, switching contexts, or wanting
  a snapshot of project health across multiple codebases.
version: 1.0.0
license: MIT
---

# Project Status

Runs a health check across all projects in the working directory and reports a concise dashboard.

## How to use

- `/project-status`
  Scan all projects in the current working directory.

- `/project-status <project-name>`
  Check a specific project only.

## Workflow

1. **Discover projects**: Find all directories containing a `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, or similar project manifest within the working directory (1 level deep by default).

2. **For each project, check**:

### Git Status
- Current branch and whether it's clean or has uncommitted changes
- How far ahead/behind the remote tracking branch (if any)
- Any stashed changes

### Dependency Health
- Whether `node_modules` (or equivalent) exists — flag if missing
- Run `npm outdated` (or equivalent) and report counts: major/minor/patch updates available
- Flag any security vulnerabilities if `npm audit` data is available
- Note lockfile presence (`package-lock.json`, `bun.lockb`, etc.)

### Build Status
- Check if a build output directory exists (`dist/`, `.next/`, `build/`, etc.)
- If a build script exists, note whether the build output appears fresh or stale (compare source file timestamps vs build output)
- Do NOT run builds — just inspect what's there

### Environment Config
- Check if `.env` or `.env.local` exists
- Check if `.env.example` exists and compare keys — flag any missing env vars
- Do NOT read or display env var values — only check key names

### Dev Server / Ports
- Check if common dev ports (3000, 3001, 5173, 8080, etc.) are in use
- If a dev server appears to be running, note it

## Output Format

Present results as a compact dashboard:

```
## Project Status Dashboard

### customer-app (Next.js)
  Git:    main | 2 uncommitted files | up to date with remote
  Deps:   installed | 3 major, 5 minor updates available | 0 vulnerabilities
  Build:  .next/ exists, built 2h ago
  Env:    .env.local present | all keys from .env.example accounted for
  Server: port 3000 in use (dev server likely running)

### prompts-mcp-server (Node.js)
  Git:    main | clean | no remote tracking
  Deps:   installed | up to date | 0 vulnerabilities
  Build:  dist/ exists, stale (sources newer than build)
  Env:    no .env found | no .env.example
  Server: port 3000 in use (conflict with customer-app?)
```

## Severity Indicators

Use these markers for quick scanning:

- **OK** — everything looks good
- **WARN** — not broken but worth attention (stale build, outdated deps, missing lockfile)
- **ISSUE** — likely problem (missing node_modules, missing required env vars, uncommitted changes on main)

## Rules

- Never run builds, installs, or destructive commands — this is read-only inspection
- Never display environment variable values — only key names
- Keep output concise — this is a dashboard, not a full audit
- If a project type isn't recognized, skip it with a note rather than guessing
- When checking ports, use `lsof` on macOS or `ss`/`netstat` on Linux
- For monorepos, check the root and immediate workspace packages
