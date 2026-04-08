# Issue Triage Guide for openabdev/openab

## Steps

1. **Check scope** — is the feature/backend involved officially supported? Check README and `config.toml.example` for supported backends, platforms, and configurations. If not supported, link to existing FRs or file a new one.
2. **Search for duplicates** — search existing issues for the same root cause or overlapping scope. Link or close as duplicate if covered elsewhere.
3. **Confirm type** — ensure one of: `bug`, `feature`, `guidance`
4. **Verify claims** — be skeptical; find source code or official docs to confirm before accepting a bug report as valid
5. **Set priority** — add exactly one:
   - `p0` 🔴 Critical — drop everything
   - `p1` 🟠 High — address this sprint
   - `p2` 🟡 Medium — planned work
   - `p3` 🟤 Low — nice to have
6. **Remove `needs-triage`** — triage complete

## Priority Guidelines

| Priority | Criteria |
|----------|----------|
| p0 | Security vulnerability, data loss, entire system down |
| p1 | Major feature broken for a class of users (e.g. all Claude Code / Cursor users) |
| p2 | Bug with workaround, or planned feature work |
| p3 | Minor improvement, cosmetic, nice to have |

## Supported Backends (check before triaging)

| Preset | CLI | Status |
|--------|-----|--------|
| (default) | Kiro CLI | ✅ Supported |
| `codex` | Codex | ✅ Supported |
| `claude` | Claude Code | ✅ Supported |
| `gemini` | Gemini CLI | ✅ Supported |

Issues involving unsupported backends (e.g. Cursor) should be linked to the relevant FR and triaged accordingly — don't treat them as p1 bugs against openab.

## Response Template

- **Issue at a Glance** — always include an ASCII diagram showing the flow and where things break
- Acknowledge the issue by investigating the relevant source code or official docs
- Confirm root cause or ask clarifying questions
- Link relevant spec/doc references when available
- Invite PR or state next steps
- **Draft response for human approval before posting to the issue comment**

## Issue at a Glance Example

```
Discord User ──► openab ──► Claude Code / Cursor agent
                   │
                   ▼
          session/request_permission
          (agent asks: "can I run this tool?")
                   │
                   ▼
          openab auto-reply (WRONG shape):
          ┌─────────────────────────────────┐
          │ { "optionId": "allow_always" }  │  ← flat, no wrapper
          └─────────────────────────────────┘
                   │
                   ▼
          SDK cannot find `outcome` field
          → treats as REFUSAL ❌
```
