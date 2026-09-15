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
