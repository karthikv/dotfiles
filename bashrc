# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@ubuntu\[\033[00m\]:\[\033[01;34m\]${PWD#"${PWD%/*/*}/"}\[\033[00m\]\$ '
else
  # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  PS1='${debian_chroot:+($debian_chroot)}\u@ubuntu:${PWD#"${PWD%/*/*}/"}\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}ubuntu\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export LS_COLORS="${LS_COLORS}ow=1;36"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=nvim
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export FZF_DEFAULT_COMMAND="ag -g '.*'"

eval "$(rbenv init -)"
eval "$(jump shell --bind=z)"

# Run ssh-agent and source env variables.
SSH_ENV="$HOME/.ssh/environment"

start_ssh_agent() {
  echo "Starting ssh-agent... "
  /usr/bin/ssh-agent | sed "s/^echo/#echo/" > "${SSH_ENV}"

  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  if ! ps ax | grep "^\s*${SSH_AGENT_PID}.*ssh-agent$" > /dev/null; then
    start_ssh_agent
  fi
else
  start_ssh_agent
fi

# vim aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias rmv='find . -type f -regex ".*\.sw[pon]" -exec rm -f {} \;'

# tmux aliases
alias tmux='TERM=xterm-256color tmux'

# git aliases
alias g='git'
alias gi='git init'
alias ga='git add'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gf='git fetch'
alias gfk='git fetch karthikv'
alias gfo='git fetch origin'
alias gr='git rebase'
alias gm='git merge'
alias gb='git branch'
alias gp='git push'

current_branch() {
  git rev-parse --abbrev-ref HEAD
}
gdv() {
  git diff -w "$@" | nvim -R -
}
gdcv() {
  git diff --cached -w "$@" | nvim -R -
}

alias gro='git rebase origin/$(current_branch)'
alias gmo='git merge origin/$(current_branch)'
alias gcb='git checkout -b'
alias gpo='git push -u origin $(current_branch)'
alias gpk='git push -u karthikv $(current_branch)'
alias grs='git reset --soft'
alias grh='git reset --hard'
alias grho='git reset --hard origin/$(current_branch)'
alias grhk='git reset --hard karthikv/$(current_branch)'
alias gc='git checkout'
alias gsh='git stash'
alias gsha='git stash apply'
alias gshl='git stash list'
alias gshp='git stash pop'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias grbdo='git push origin'
alias grbdk='git push karthikv'
alias gra='git remote add'
alias grm='git remote rm'
alias gcl='git changelog'
alias gca='git commit -va'
alias gct='git commit -v'

# hub aliases
alias hc='hub create'
alias hb='hub browse'
alias hp='hub pull-request'
alias hpi='hub pull-request -i'

# node aliases
alias ndm='nodemon'

# directory aliases
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

# nodefront aliases
alias nodefront='~/Active/nodefront/nodefront.js'
alias nf='nodefront'

# docker aliases
alias d='docker'
alias db='docker build'
alias dr='docker run'
alias de='docker exec'
alias drm='docker rm'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias ds='docker stop'
alias dl='docker logs'
alias dst='docker stats'
alias dsa='docker stop `docker ps -aq`'
alias di='docker images'
alias dm='docker-machine'
alias dmi='docker-machine ip default'
alias dme='eval $(docker-machine env default)'
alias dmr='docker-machine restart default'
alias dclean='docker rm `docker ps -aq`; docker rmi `docker images -q -f "dangling=true"`'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcr='docker-compose run'
alias dvrm='docker volume rm $(docker volume ls -qf dangling=true)'

# kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgp='kubectl get po'
alias kgr='kubectl get rs'
alias kgd='kubectl get deploy'
alias kl='kubectl logs'
alias kc='kubectl create'
alias kcf='kubectl create -f'
alias kd='kubectl describe'
alias kdp='kubectl describe po'
alias kdr='kubectl describe rs'
alias kdd='kubectl describe deploy'
alias kdf='kubectl describe -f'
alias ka='kubectl apply'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias kdelf='kubectl delete -f'
alias ke='kubectl exec'

# misc aliases
alias open='explorer.exe'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
