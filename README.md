# Dotfiles by Danilosh45 ✨

Welcome to my dotfiles! This repository contains all my custom configurations for the tools and environments I use daily. I use [GNU Stow](https://www.gnu.org/software/stow/) to efficiently manage my configurations and keep them synchronized across devices.

## 🖂️ Repository Structure

The repository is organized to reflect the directory structure in `$HOME` and contains configurations for various tools. Here's an overview:

```
dotfiles/
├── zsh/                 # Configuration for the zsh shell
├── hypr/                # Configuration for hyprland Window Manager
├── waybar/            # Configuration for waybar 
├── ghostty/               # Configuration for the ghostty terminal
├── nvim/                # Configuration for Neovim
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
stow nvim
stow i3
stow kitty
stow fish
```

Each command creates the corresponding symbolic links in the appropriate directories, such as `~/.config/nvim`, `~/.config/i3`, etc.

### 4. Customize if Necessary
If you need to make machine-specific adjustments, you can edit the files directly. Don't forget to commit your changes if you want to keep them synchronized later!

## 🛠️ Included Tools

This repository contains configurations for the following tools:

- **[hyprland](https://hyprland.org/):** A tiling and floating window manager.
- **[waybar](https://github.com/Alexays/waybar):** A lightweight status bar 
- **[Kitty](https://sw.kovidgoyal.net/kitty/):** A fast and customizable terminal emulator.
- **[Neovim](https://neovim.io/):** A modern text editor for developers.
- **[zsh](https://zsh.org/):** A friendly and powerful interactive shell.

## 📌 License

This project is licensed under the [MIT](LICENSE), which means you can freely use, modify, and distribute this code.

---

### 💡 Inspiration and References

This repository is inspired by best practices for managing dotfiles, including the use of GNU Stow for symbolic links. Check out this [blog](https://medium.com/quick-programming/managing-dotfiles-with-gnu-stow-9b04c155ebad) for more information.

Thank you for visiting my dotfiles! If you have suggestions or questions, feel free to open an [issue](https://github.com/danilosh45/dotfiles/issues) or contact me. 🚀

