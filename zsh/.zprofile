# 環境変数
export LANG=ja_JP.UTF-8

# zsh-completions
fpath=(/path/to/homebrew/share/zsh-completions $fpath)

autoload -U compinit
compinit -u

# nvm
source ~/.nvm/nvm.sh
if [[ -s  /Users/a13025/.nvm/nvm.sh ]] ; then source  /Users/a13025/.nvm/nvm.sh ; fi

# nvm設定
# [[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
# nvm use default
# npm_dir=${NVM_PATH}_modules
# export NODE_PATH=$npm_dir

# git
export PATH="/usr/local/Cellar/git/2.7.0/bin:$PATH"

# gulp
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# android SDK
export PATH=$PATH:/Users/a13025/Library/Android/sdk/platform-tools

# yarn
# export PATH="$PATH:`yarn global bin`"


