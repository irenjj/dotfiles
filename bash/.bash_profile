# Called for bash as login shell, keep the file super simple

# The existence of .bash_profile prevents .profile and .bashrc from loading

if [ -f ~/.profile ]; then . ~/.profile; fi

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"

  export HOMEBREW_PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple #ckbrew
  export HOMEBREW_API_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api  #ckbrew
  export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles #ckbrew
  eval $(/opt/homebrew/bin/brew shellenv) #ckbrew


ulimit -n 102400
. "$HOME/.cargo/env"
