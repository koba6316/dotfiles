# =============================================================================
# .zprofile - ログインシェル用（1回のみ読み込み）
# 環境変数とPATH設定のみを記述
# =============================================================================

# ロケール
export LANG=ja_JP.UTF-8

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

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
typeset -U path   # 重複を自動で除去する

# Homebrew Ruby
path=(/opt/homebrew/opt/ruby/bin $path)

# Ruby gems
path=("$GEM_HOME/bin" "$HOME/.gem/ruby/3.3.0/bin" $path)

# pnpm（global bin は $PNPM_HOME/bin）
path=("$PNPM_HOME/bin" "$PNPM_HOME" $path)

# Flutter/Dart
path=("$HOME/fvm/default/bin" "$PUB_CACHE/bin" $path)

# Android SDK
path=("$ANDROID_HOME/platform-tools" $path)

# Ghostty
path=(/Applications/Ghostty.app/Contents/MacOS $path)

# Antigravity
path=("$HOME/.antigravity/antigravity/bin" $path)

# AI エージェント: .zshenv で足した mise shim を path_helper / brew の後でも先頭に保つ
is_human || path=("$HOME/.local/share/mise/shims" $path)
