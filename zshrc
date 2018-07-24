# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export PATH=node_modules/.bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=$PATH:$HOME/Bin
export PATH=$PATH:/usr/local/Cellar/opencv3/3.1.0/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/Active/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.nimble/bin

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig:$PKG_CONFIG_PATH

export GOPATH=~/Active/go
export ANDROID_HOME=/usr/local/opt/android-sdk
export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:/usr/lib:/usr/local/opt/opencv3/lib:/usr/local/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/opt/opencv3/lib/python2.7/site-packages
export EDITOR=nvim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="terminalparty"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(battery brew django extract git node npm osx pip python gpg-agent)

source $ZSH/oh-my-zsh.sh

# z command, courtesy of https://github.com/rupa/z
source $ZSH/../lib/z.sh
function precmd() {
  # keep track of directories that are popular
  _z --add "$(pwd -P)"
}

# vim aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias rmv='find . -type f -regex ".*\.sw[pon]" -exec rm -f {} \;'

# git aliases
alias gi='git init'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gf='git fetch'
alias gfk='git fetch karthikv'
alias gfo='git fetch origin'
alias gr='git rebase'
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
gdv() { git diff -w "$@" | nvim -R - }
gdcv() { git diff --cached -w "$@" | nvim -R - }
alias gbd='git branch -d'
alias gbD='git branch -D'
alias grbdo='git push origin'
alias grbdk='git push karthikv'
alias gra='git remote add'
alias grm='git remote rm'
alias gcl='git changelog'
alias gct='git commit -v'

# hub aliases
alias hc='hub create'
alias hb='hub browse'
alias hp='hub pull-request'
alias hpi='hub pull-request -i'

# node
alias ndm='nodemon'

# easy directory switching
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

# nodefront
alias nodefront='~/Active/nodefront/nodefront.js'
alias nf='nodefront'

# docker
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

# kubernetes
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

# newer make
alias make='gmake'

# rbenv
eval "$(rbenv init -)"

# shortcuts
bindkey '[C' forward-word
bindkey '[D' backward-word

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# OSX has too low a limit on open files, so increase it:
# https://superuser.com/questions/827984/open-files-limit-does-not-work-as-before-in-osx-yosemite/828010#828010
ulimit -n 65536 65536
