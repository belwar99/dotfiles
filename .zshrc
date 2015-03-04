# Created by belwar99 for 5.0.6

### 補完機能 ###
autoload -U compinit
compinit
setopt list_packed	#補完候補を詰めて表示

eval `dircolors -b`	#GNUの色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} #補完候補にも色付
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' #大文字補完

#### 環境変数-文字コード ###
export LANG=ja_JP.UTF-8

### プロンプトの表示設定 ###
# http://d.hatena.ne.jp/oovu70/20120405/p1
# プロンプトに色を付ける
autoload -U colors; colors

# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
    tmp_prompt="%B%U${tmp_prompt}%u%b"
    tmp_prompt2="%B%U${tmp_prompt2}%u%b"
    tmp_rprompt="%B%U${tmp_rprompt}%u%b"
    tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

### ターミナルタイトル ###
case "${TERM}" in
    kterm*|xterm)
	precmd() {
	    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	}
	;;
esac


### コマンド履歴 ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

### キーバインド ###
bindkey -e

### CD絡み ###
setopt auto_pushd	#過去に行ったディレクトリを遡る cd -(tab)
setopt correct		#コマンドの訂正

### エイリアス ###
alias ls="ls -G --color=auto"
alias la="ls -A"
alias lf="ls -F"
alias ll="ls -l"
alias l.="ls -dA .*"

alias du="du -h"
alias df="df -h"

### CDした時にそのディレクトリをls
function cd() {builtin cd $@&& ls; }
