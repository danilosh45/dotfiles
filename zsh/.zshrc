# ~/.zshrc — core shell setup (zsh + oh-my-zsh)
# Requiere: oh-my-zsh instalado (ver README.md)

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Plugins: los dos últimos son externos, ver README.md para instalarlos
plugins=(
  git
  sudo
  docker
  kubectl
  terraform
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --- Historial ---
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# --- Alias de infra ---
alias k='kubectl'
alias tf='terraform'
alias ll='ls -alh'
alias la='ls -A'

# --- Editor por defecto ---
export EDITOR='vim'
export VISUAL='vim'
export KUBECONFIG=~/.kube/zakuii

# opencode
export PATH=/home/dan/.opencode/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
