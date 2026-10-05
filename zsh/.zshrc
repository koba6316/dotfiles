# =============================================================================
# .zshrc - 人間の対話シェル専用
# AI エージェントのシェルでは何も読まない（判定は .zshenv の is_human）
# =============================================================================
is_human || return 0

# -----------------------------------------------------------------------------
# 履歴・シェルオプション（oh-my-zsh が肩代わりしていた設定）
# -----------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE
setopt AUTO_CD INTERACTIVE_COMMENTS
export CLICOLOR=1

# -----------------------------------------------------------------------------
# 補完（プラグインが compdef を呼ぶため、プラグインより前に初期化する）
# dump は 1 日 1 回だけ再生成し、普段はキャッシュを使う
# -----------------------------------------------------------------------------
fpath=(/opt/homebrew/share/zsh-completions $fpath)   # brew: zsh-completions
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -----------------------------------------------------------------------------
# プラグイン（Sheldon: 定義は config/sheldon/plugins.toml）
# 生成スクリプトをキャッシュし、plugins.toml 更新時だけ再生成する
# -----------------------------------------------------------------------------
if command -v sheldon >/dev/null 2>&1; then
  _sheldon_toml="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.toml"
  _sheldon_cache="${XDG_CACHE_HOME:-$HOME/.cache}/sheldon/sheldon.zsh"
  if [[ ! -r $_sheldon_cache || $_sheldon_toml -nt $_sheldon_cache ]]; then
    mkdir -p "${_sheldon_cache:h}"
    sheldon source > "$_sheldon_cache"
  fi
  source "$_sheldon_cache"
  unset _sheldon_toml _sheldon_cache
else
  print -u2 "sheldon が未導入です: brew install sheldon"
fi

# -----------------------------------------------------------------------------
# プロンプト（robbyrussell 風。外部テーマに依存しない）
# -----------------------------------------------------------------------------
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats ' %F{blue}git:(%F{red}%b%F{blue})%f'
setopt PROMPT_SUBST
PROMPT='%(?:%F{green}➜ :%F{red}➜ ) %F{cyan}%c%f${vcs_info_msg_0_} '

# -----------------------------------------------------------------------------
# ランタイム管理（mise に一本化: node / go / uv など）
# -----------------------------------------------------------------------------
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# uv など ~/.local/bin の環境設定
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Dart completion
[[ -f ~/.dart-cli-completion/zsh-config.zsh ]] && . ~/.dart-cli-completion/zsh-config.zsh

# -----------------------------------------------------------------------------
# エイリアス
# -----------------------------------------------------------------------------
alias flutter="fvm flutter"

# multi-agent-kairai
alias css='cd "$HOME/multi-agent-kairai" && ./mission_start.sh'
alias csm='cd "$HOME/multi-agent-kairai"'

# -----------------------------------------------------------------------------
# ローカル設定（機密情報用、Git管理外）
# -----------------------------------------------------------------------------
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
