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
export NODE_PATH=$npm_dir

# git
export PATH="/usr/local/Cellar/git/2.7.0/bin:$PATH"

# gulp
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# android SDK
export PATH=$PATH:/Users/a13025/Library/Android/sdk/platform-tools

export GEM_HOME=~/extlib/gems
export PATH=$PATH:/extlib/gems/bin/
eval "$(rbenv init -)"

# yarn
export PATH=$PATH:`yarn global bin`

# wp
source "/usr/local/bin/wp-completion.bash"

export NPM_TOKEN="e7918aea-2032-461a-af23-c30f663fcd07"
export GITHUB_PERSONAL_ACCESS_TOKEN="8429d7ec3c26113580f3a467604f460cf5dcc50e"
