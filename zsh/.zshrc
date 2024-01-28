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
fi

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
source $HOME/.cargo/env
export PATH=/usr/local/lib:$PATH
export CARGO_HTTP_MULTIPLEXING=false

# --------------------------------------------------
# alias
alias rdb=rust-lldb
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias n=nvim
alias vim=nvim


if [ "$(uname)"=="Darwin" ]; then
    alias ls='exa --group-directories-first --classify'
    alias la='exa --group-directories-first --classify --all' # 'ls -A'
    alias ll='exa --long --group-directories-first --classify --all' # 'ls -alF'
fi

# --------------------------------------------------
# oh my zsh config 
ZSH_THEME="robbyrussell"
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

