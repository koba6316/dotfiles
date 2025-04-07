# 環境変数
export LANG=ja_JP.UTF-8

# nvm環境変数の設定
export NVM_DIR="$HOME/.nvm"

# PATH設定（システム全体で必要なもの）
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# その他の環境変数
export GEM_HOME=~/extlib/gems

# Android SDK
export PATH=$PATH:/Users/a13025/Library/Android/sdk/platform-tools

# Flutter
export PATH="/Users/a13025/fvm/versions/3.24.3/bin:$PATH"

# zsh-completions
fpath=(/opt/homebrew/share/zsh-completions $fpath)
