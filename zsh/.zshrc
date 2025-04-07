# nvm設定
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # nvm読み込み
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # 補完機能

# Node.jsバージョン設定（エラーを表示しない）
nvm use 22.14.0 > /dev/null 2>&1 || true

# antigen（プラグイン管理）
source ~/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle --loc=plugins/ssh-agent/ssh-agent.plugin.zsh
antigen theme robbyrussell
antigen apply

# 補完設定
autoload -U compinit
compinit -u

# その他のツール設定
# rbenv
eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/Users/a13025/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# rvm
source $HOME/.rvm/scripts/rvm
export PATH="$HOME/.rvm/bin:$PATH"

# ルビー設定
export PATH="$HOME/.gem/ruby/2.4.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
export PATH="$HOME/extlib/gems/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
