---
name: suggest-flags
description: Analyze a pull request diff or issue description and suggest feature flags that should be created, including recommended keys, names, and flag types
disable-model-invocation: false
---

# Suggest Feature Flags

Analyzes code changes or issue context and produces a structured list of feature flag recommendations. Use this skill when you want to identify flag opportunities before committing to creation.

## Input

Provide one of:
- A PR diff or code snippet
- An issue title and body
- A plain description of the feature being built

## What to look for

Scan the input for:
- New conditional logic (`if`, `switch`, feature checks) guarding new behavior
- Comments like `TODO: gate this`, `feature flag`, `experiment`, or `rollout`
- Functions or components that are entirely new and user-facing
- Database migrations or API changes that require coordinated rollout
- A/B test setups or percentage-based rollouts

## Output format

Return a recommendation list:

```
Suggested flags:

1. **{flag_name}** (`{flag_key}`)
   Type: boolean | temporary: true/false
   Why: {one sentence rationale}
   Gate: {describe what code/behavior this flag should wrap}

2. ...
```

If no flag opportunities are found, say so explicitly: "No feature flag opportunities detected in the provided context."

## Notes

- Prefer fewer, well-scoped flags over many granular ones
- Mark flags as `temporary: true` if they are for a rollout or experiment (intended to be cleaned up)
- Mark flags as `temporary: false` for kill switches or long-lived operational controls
