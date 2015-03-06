# Created by belwar99 for 5.0.6


### 補完機能 ###
autoload -Uz compinit
compinit
setopt list_packed	#補完候補を詰めて表示

eval `dircolors -b`	#GNUの色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} #補完候補にも色付
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' #大文字補完


#### 環境変数-文字コード ###
export LANG=ja_JP.UTF-8


### プロンプトの表示設定 ###
# プロンプトに色を付ける
autoload -Uz colors
colors

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

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


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
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_reduce_blanks   # 余分なスペースを削除する


### キーバインド ###
bindkey -e


### CD絡み ###
setopt auto_pushd	#過去に行ったディレクトリを遡る cd -(tab)
setopt pushd_ignore_dups #重複したディレクトリを追加しない
setopt correct		#コマンドの訂正
setopt auto_cd		#ディレクトリ名だけでCD
function cd() {builtin cd $@&& ls; }	# CDした時にそのディレクトリをls


### エイリアス ###
alias ls="ls -FG --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias l.="ls -dA .*"

alias du="du -h"
alias df="df -h"


### バージョン管理システムで管理されているディレクトリの詳細を表示
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
 
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
 
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


### オプション ###
#日本語のファイル名を表示可能にする
setopt print_eight_bit

# beep 無効
setopt no_beep

# 高機能なワイルドカード展開を使用
setopt extended_glob
