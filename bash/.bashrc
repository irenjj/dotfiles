# --------------------------------------------------
# enviroment path
if [ "$(uname)"=="Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
#export TERM=xterm-256color

# --------------------------------------------------
# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias vim=nvim
alias lg=lazygit
alias cbd='cargo build'

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
# Desktop notification
function nf() {
    local start_time=$(date +%s)
    "$@"
    local exit_code=$?

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    if [ $duration -gt 5 ]; then
        local cmd_name="$1"
        if [ $exit_code -eq 0 ]; then
            kitten notify $cmd_name "✅"
        else
            kitten notify $cmd_name "❌"
        fi
    fi

    return $exit_code
}

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
PS1=$PS1':\[\033[01;34m\]\w\[\033[00m\]'

# git
PS1=$PS1'`__git_ps1 " (%s)"`'

# last command status
export PS1=$PS1'\n\[\033[01;05m\]\$ \[\033[00m\]' # UID symbol
