export NODE_PATH=/usr/local/lib/node_modules


source ~/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle --loc=plugins/ssh-agent/ssh-agent.plugin.zsh
antigen theme robbyrussell

antigen apply

source ~/dotfiles/zsh/.zprofile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.gem/ruby/2.4.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

export PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
