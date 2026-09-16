# GitHub MCP server token (stored in macOS Keychain, not in plaintext)
# fine-grained PAT (ca-dokusho 承認済み / 2026-09-16)。権限は Actions, Commit statuses,
# Contents, Issues, Pull requests = RW / Metadata = RO 。
export GITHUB_MCP_TOKEN="$(security find-generic-password -s github-mcp-token -w 2>/dev/null)"
