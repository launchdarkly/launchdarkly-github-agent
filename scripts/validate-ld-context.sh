#!/usr/bin/env bash
# Validates that required LaunchDarkly context is available before the agent runs.
# Exits non-zero to abort the run if the environment is misconfigured.

set -euo pipefail

if [ -z "${GITHUB_COPILOT_OIDC_MCP_TOKEN:-}" ] && [ -z "${LD_API_KEY:-}" ]; then
  echo "ERROR: No LaunchDarkly authentication token available." >&2
  echo "Ensure the plugin's MCP server OIDC configuration is correct, or set LD_API_KEY." >&2
  exit 1
fi

exit 0
