---
name: list-flags
description: List existing LaunchDarkly feature flags in a project, optionally filtered by tag or search query, to check for duplicates before creating new flags
disable-model-invocation: false
---

# List LaunchDarkly Feature Flags

Retrieves existing feature flags from a LaunchDarkly project. Use this before calling `create-flag` to avoid creating duplicates.

## Parameters

- **project_key** — LaunchDarkly project key (required)
- **search** — Optional text to filter flags by name or key
- **tag** — Optional tag filter (e.g., `repo:my-org/my-repo`)
- **limit** — Max number of flags to return (default: 20)

## Steps

1. Call the LaunchDarkly MCP `list_feature_flags` tool with the project key and any filters.
2. Return a summary list with each flag's key, name, and creation date.
3. If a flag matching the intended key already exists, highlight it clearly.

## Output format

Return a concise list:

```
Existing flags in project '{project_key}':
- `{flag_key}` — {flag_name} (created {date})
- ...
```

If no flags match, state "No existing flags found matching your criteria."
