# Caio's NeoVim Configuration

This set of files configures NeoVim with sane defaults and adds a few plugins that make life enjoyable again.

## Requirements

`Packer.nvim` is required for this repository to work. Follow instructions at https://github.com/wbthomason/packer.nvim#quickstart

At the time of this writing, this is how you'd install Packer:

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Installation

Go to `~/.config` and clone this repository:

```sh
git clone https://github.com/CaioBianchi/nvim
```

Open up NeoVim and run:

```vimscript
:PackerCompile
:PackerInstall
```

## Usage

- Add new plugins to https://github.com/CaioBianchi/nvim/blob/main/lua/plugins.lua
  - Configure/Init/Setup those plugins @ https://github.com/CaioBianchi/nvim/blob/main/lua/settings.lua

- Add keystroke mappings to https://github.com/CaioBianchi/nvim/blob/main/lua/mappings.lua


## Updating

Updating plugins is as easy as running the following command in NeoVim:

```vimscript
:PackerSync
```
