---
name: create-flag
description: Create a new LaunchDarkly feature flag in the specified project with the given key, name, description, and tags
disable-model-invocation: false
---

# Create LaunchDarkly Feature Flag

Creates a new boolean feature flag in LaunchDarkly. Invoke this skill when you have identified a concrete flag to create and have all required parameters ready.

## Required parameters

Provide all of the following in your invocation:

- **project_key** — LaunchDarkly project key (e.g., `default`, `my-project`)
- **flag_key** — Unique flag key: lowercase letters, numbers, and hyphens only (e.g., `new-checkout-flow`)
- **flag_name** — Human-readable display name (e.g., `New Checkout Flow`)
- **description** — One sentence describing what this flag gates

## Optional parameters

- **tags** — Comma-separated list of tags (e.g., `repo:my-org/my-repo,pr:42`)
- **temporary** — `true` for short-lived experiment/rollout flags; `false` for permanent kill switches (default: `true`)
- **flag_type** — `boolean` (default), `string`, `number`, or `json`

## Steps

1. Use the LaunchDarkly MCP tool `create_feature_flag` with the provided parameters.
2. Confirm creation by calling `get_feature_flag` with the project key and flag key.
3. Return the flag key, name, and a direct URL to the flag dashboard.

## Output format

After successful creation, report:

```
Created flag: **{flag_name}** (`{flag_key}`)
Project: {project_key}
URL: https://app.launchdarkly.com/projects/{project_key}/flags/{flag_key}
```

If the flag already exists, report that clearly and provide the existing flag's URL instead of creating a duplicate.
