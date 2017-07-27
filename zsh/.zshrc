export NODE_PATH=/usr/local/lib/node_modules

source ~/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle --loc=plugins/ssh-agent/ssh-agent.plugin.zsh
antigen theme robbyrussell

antigen apply

source ~/dotfiles/zsh/.zprofile
