# =============================================================================
# .zprofile - ログインシェル用（1回のみ読み込み）
# 環境変数とPATH設定のみを記述
# =============================================================================

# ロケール
export LANG=ja_JP.UTF-8

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm
export NVM_DIR="$HOME/.nvm"

# Ruby (gem)
export GEM_HOME="$HOME/extlib/gems"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# Flutter/Dart
export FLUTTER_ROOT="$HOME/fvm/default"
export PUB_CACHE="$HOME/.pub-cache"

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"

# =============================================================================
# PATH設定（優先度順：先に追加したものが優先）
# =============================================================================

# Homebrew Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Ruby gems
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.3.0/bin:$PATH"

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Flutter/Dart
export PATH="$HOME/fvm/default/bin:$PATH"
export PATH="$PUB_CACHE/bin:$PATH"

# Android SDK
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# zsh-completions
fpath=(/opt/homebrew/share/zsh-completions $fpath)
