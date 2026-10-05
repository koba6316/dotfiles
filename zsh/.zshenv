# =============================================================================
# .zshenv - 全シェルで読み込み（AI / 人間の判定と共有環境変数）
# 方針: デフォルトは AI。人間向けの設定は is_human のときだけ opt-in する
# =============================================================================

# 人間の対話ターミナルか判定する（TTY があり、かつ AI エージェントの環境変数がない）
is_human() {
  [[ -t 0 && -t 1 ]] || return 1
  [[ -z "${AI_AGENT:-}${CLAUDECODE:-}${CODEX_COMPANION_SESSION_ID:-}${CURSOR_AGENT:-}" ]]
}

# GitHub MCP server token (stored in macOS Keychain, not in plaintext)
# fine-grained PAT (ca-dokusho 承認済み / 2026-09-16)。権限は Actions, Commit statuses,
# Contents, Issues, Pull requests = RW / Metadata = RO 。
# 設定済み（親シェルから継承）なら Keychain を呼ばない。
: "${GITHUB_MCP_TOKEN:=$(security find-generic-password -s github-mcp-token -w 2>/dev/null)}"
export GITHUB_MCP_TOKEN

# Node 系ツールが使う CA bundle（Claude Code 用）
[[ -r "$HOME/.local/share/claude/ca-bundle.pem" ]] && export NODE_EXTRA_CA_CERTS="$HOME/.local/share/claude/ca-bundle.pem"

if ! is_human; then
  # AI 側: 対話・ページャを避ける
  export EDITOR=true PAGER=cat GIT_PAGER=cat
  # .zshrc を読まないため、mise の shim でランタイムのバージョンを解決する
  typeset -U path
  path=("$HOME/.local/share/mise/shims" $path)
fi
