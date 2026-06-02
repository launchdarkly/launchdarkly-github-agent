# LaunchDarkly Copilot Agent

A [GitHub Agent HQ & Copilot CLI plugin](https://github.com/apps/launchdarkly-agent) that creates and manages LaunchDarkly feature flags and AI Configs directly from pull requests, issues, and discussions.

Install the [GitHub app](https://github.com/apps/launchdarkly-agent), then @-mention or assign the agent on a PR/issue and it will analyze the diff, detect rollout candidates or LLM calls, and create the right flag or AgentControl Config in LaunchDarkly.

## What it does

- **Feature flag automation** — Detects new behavior, conditional logic, or rollout language in PRs/issues and creates a flag with derived key, tags, and description. Avoids duplicates by checking LaunchDarkly first.
- **AI Config automation** — Spots direct LLM provider calls (OpenAI, Anthropic, Bedrock, Gemini, Strands) and hardcoded prompts/models, then creates or migrates them to a managed AI Config.
- **Targeting & guarded rollouts** — Configures percentage rollouts, attribute rules, segments, and health-monitored ramps.
- **Cleanup** — Removes stale flag evaluations and archives flags after a rollout completes.

## Structure

```
launchdarkly-agent/
├── plugin.json              # Plugin manifest
├── hooks.json               # Deterministic pre/post hooks
├── agents/
│   ├── main.agent.md        # Entry point — invoked by @-mentions and assignments
│   ├── flag-creator.agent.md
│   └── aiconfig-creator.agent.md
├── skills/                  # Callable skills for flags and AI Configs
└── scripts/
    └── validate-ld-context.sh
```

The main agent uses the LaunchDarkly MCP server (`https://mcp.launchdarkly.com/mcp/fm`) via a bearer token supplied as `COPILOT_MCP_LD_API_KEY`.

## Install

Install the [LaunchDarkly Agent GitHub](https://github.com/apps/launchdarkly-agent) app in your repository or organization in order to manage LaunchDarkly feature flags and AgentControl configs  

### Required secret

Set `COPILOT_MCP_LD_API_KEY` as an Agent secret in the repository (or org) where the plugin runs. The `COPILOT_MCP_` prefix is required for the value to be routed to the MCP server.

### Local development

```bash
# Install from a local checkout
copilot plugin install ./launchdarkly-agent

# Or directly from this repo
copilot plugin install <owner>/launchdarkly-agent

# Verify
copilot plugin list
/agent
/skills list

# Re-install after edits (artifacts are cached)
copilot plugin install ./launchdarkly-agent

# Uninstall
copilot plugin uninstall launchdarkly-flag-automation
```

## Conventions

- Flag and AI Config keys are lowercase, hyphen-separated (e.g., `new-checkout-flow`, `support-ticket-summarizer`).
- Flags are tagged with `repo:<owner>/<repo>` and `pr:<n>` / `issue:<n>` for traceability.
- AI Configs use **agent mode** when they need tools or hand-offs; **completion mode** for one-shot prompts.
- When no LaunchDarkly project is wired up, the agent runs `aiconfig-projects` first rather than guessing structure.
