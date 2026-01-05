# =============================================================================
# .zshrc - インタラクティブシェル用（毎回読み込み）
# プラグイン、補完、エイリアス、ツール初期化を記述
# =============================================================================

# -----------------------------------------------------------------------------
# Antigen（プラグイン管理）
# -----------------------------------------------------------------------------
source ~/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle --loc=plugins/ssh-agent/ssh-agent.plugin.zsh
antigen theme robbyrussell
antigen apply

# -----------------------------------------------------------------------------
# 補完設定
# -----------------------------------------------------------------------------
autoload -U compinit
compinit -u

# -----------------------------------------------------------------------------
# ツール初期化（インタラクティブシェルで必要なもの）
# -----------------------------------------------------------------------------

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
nvm use 22.14.0 > /dev/null 2>&1 || true

# rbenv
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# rvm
if [ -s "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm"
  export PATH="$HOME/.rvm/bin:$PATH"
fi

# asdf
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -x "$(command -v brew)" ] && [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ] && source "$(brew --prefix asdf)/libexec/asdf.sh"

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Dart completion
[[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && . ~/.dart-cli-completion/zsh-config.zsh

# -----------------------------------------------------------------------------
# エイリアス
# -----------------------------------------------------------------------------
alias flutter="fvm flutter"

# -----------------------------------------------------------------------------
# プロジェクト固有設定（カレントディレクトリ依存）
# -----------------------------------------------------------------------------
# FVM使用時のプロジェクト用（必要に応じてコメント解除）
# [ -d ".fvm/flutter_sdk" ] && export PATH="$(pwd)/.fvm/flutter_sdk/bin:$PATH"

# -----------------------------------------------------------------------------
# ローカル設定（機密情報用、Git管理外）
# -----------------------------------------------------------------------------
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
