# Dotfiles by Danilosh45 ✨

Welcome to my dotfiles! This repository contains all my custom configurations for the tools and environments I use daily. I use [GNU Stow](https://www.gnu.org/software/stow/) to efficiently manage my configurations and keep them synchronized across devices.

My current workflow: **GNOME** (stock, keyboard-driven) + **GNOME Terminal** with **zsh** (oh-my-zsh) as my shell and **vim** as my core editor for infrastructure work (IaC, config files, plain text). For heavy coding I use an IDE with vim mode.

> 🗃️ The old Hyprland/Wayland stack (hyprland, waybar, wofi, swaync, ghostty, fastfetch, remmina) is archived in the [`hyprland-legacy`](https://github.com/danilosh45/dotfiles/tree/hyprland-legacy) branch.

## 🖂️ Repository Structure

The repository is organized to reflect the directory structure in `$HOME`:

```
dotfiles/
├── zsh/                 # zsh + oh-my-zsh configuration (~/.zshrc)
├── vim/                 # Minimal vim configuration (~/.vimrc)
└── ...                  # Other configuration directories
```

## 🚀 Installation

Follow these steps to install and use my dotfiles:

### 1. Clone the Repository
First, clone the repository into your `$HOME` directory:

```bash
git clone git@github.com:danilosh45/dotfiles.git ~/dotfiles
```

### 2. Install GNU Stow
If you don't have Stow installed, you can easily do so:

- **Debian/Ubuntu**:
  ```bash
  sudo apt install stow
  ```
- **Arch Linux**:
  ```bash
  sudo pacman -S stow
  ```
- **Fedora**:
  ```bash
  sudo dnf install stow
  ```

### 3. Link Configurations
Navigate to the repository directory and use Stow to create symbolic links for the configurations:

```bash
cd ~/dotfiles
stow zsh
stow vim
```

Each command creates the corresponding symbolic links in the appropriate directories, such as `~/.zshrc` or `~/.vimrc`.

### 4. Set up zsh + oh-my-zsh

Install zsh and oh-my-zsh:

```bash
# Arch Linux
sudo pacman -S zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install the external plugins used in `.zshrc`:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Make zsh your default shell:

```bash
chsh -s $(which zsh)
```

### 5. Customize if Necessary
If you need to make machine-specific adjustments, you can edit the files directly. Don't forget to commit your changes if you want to keep them synchronized later!

## 🛠️ Included Tools

This repository contains configurations for the following tools:

- **[zsh](https://zsh.org/):** A friendly and powerful interactive shell, with [oh-my-zsh](https://ohmyz.sh/).
- **[Vim](https://www.vim.org/):** Minimal, plugin-free setup with my custom keybindings — the core of my infra workflow.

## 📌 License

This project is licensed under the [MIT](LICENSE), which means you can freely use, modify, and distribute this code.

---

### 💡 Inspiration and References

This repository is inspired by best practices for managing dotfiles, including the use of GNU Stow for symbolic links. Check out this [blog](https://medium.com/quick-programming/managing-dotfiles-with-gnu-stow-9b04c155ebad) for more information.

Thank you for visiting my dotfiles! If you have suggestions or questions, feel free to open an [issue](https://github.com/danilosh45/dotfiles/issues) or contact me. 🚀
