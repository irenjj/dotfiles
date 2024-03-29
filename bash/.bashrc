# --------------------------------------------------
# enviroment path
if [ "$(uname)"=="Darwin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH=$(brew --prefix llvm)/bin:$PATH
    export PATH=/opt/homebrew/Cellar/binutils/2.41/bin:$PATH
    export CC=$(brew --prefix llvm)/bin/clang
    export CXX=$(brew --prefix llvm)/bin/clang++
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export BASH_SILENCE_DEPRECATION_WARNING=1
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"
    export FDB_CLUSTER_FILE="/usr/local/etc/foundationdb/fdb.cluster"
fi

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
source $HOME/.cargo/env
export PATH=/usr/local/lib:$PATH
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
export DYLD_LIBRARY_PATH=/usr/local/lib

# --------------------------------------------------
# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias vim=nvim
alias lg=lazygit

# rust
alias rdb=rust-lldb
alias ctn='cargo test --no-run'

if [ "$(uname)"=="Darwin" ]; then
    alias ls='exa --group-directories-first --classify'
    alias la='exa --group-directories-first --classify --all' # 'ls -A'
    alias ll='exa --long --group-directories-first --classify --all' # 'ls -alF'
fi

# --------------------------------------------------
# install git tools

# Make $__git_ps1 available, https://stackoverflow.com/a/15398153
if [[ ! -f ~/.git-prompt.sh ]]
then
    curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh
fi
source ~/.git-prompt.sh

# Git autocompletion for Bash, https://stackoverflow.com/a/19876372
if [[ ! -f ~/.git-completion.bash ]]
then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/.git-completion.bash
fi
source ~/.git-completion.bash

# In order to make this fast enough ignore submodules in large repos. Change in .git-prompt.sh
#      git diff --no-ext-diff --quiet || w="*"
#      git diff --no-ext-diff --cached --quiet || i="+"
# to
#      git diff --no-ext-diff --quiet -- :!contrib || w="*"
#      git diff --no-ext-diff --cached --quiet -- :!contrib || i="+"
# (search for GIT_PS1_SHOWDIRTYSTATE)
# See
# - https://seb.jambor.dev/posts/performance-optimizations-for-the-shell-prompt/
# - https://css-tricks.com/git-pathspecs-and-how-to-use-them/
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM='auto'


# --------------------------------------------------
# PS1 format
# time
PS1='\[\033[00m\][\t] '

# user and host
if [[ "$(uname)"=="Darwin" ]]; then
  PS1=$PS1'\[\033[01;35m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]'
else
  PS1=$PS1'\[\033[01;32m\]\u\[\033[00m\]@\[\033[32m\]\h\[\033[00m\]'
fi

# working directory
PS1=$PS1':\[\033[01;36m\]\w\[\033[00m\]'

# git
PS1=$PS1'`__git_ps1 " (%s)"`'

# last command status
export PS1=$PS1'\n\[\033[01;05m\]\$ \[\033[00m\]' # UID symbol

# --------------------------------------------------
# fzf configuration
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
