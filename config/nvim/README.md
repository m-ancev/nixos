# ma.nvim

## Installation

### Linux

Dependencies

```bash
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```

Clone

```bash
git clone git@github.com:m-ancev/ma.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

### Windows

Dependencies

- [MSYS2](https://www.msys2.org/#installation)

```powershell
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```

Clone

```powershell
git clone https://github.com/m-ancev/ma.nvim.git %userprofile%\AppData\Local\nvim\
```
## Structure

![structure.svg](./misc/structure.svg)

