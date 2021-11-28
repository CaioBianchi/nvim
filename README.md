# Caio's NeoVim Configuration

This set of files configures NeoVim with sane defaults and adds a few plugins that makes life enjoyable again.

## Installation

Go to `~/.config` and clone this repository:

```sh
git clone https://github.com/CaioBianchi/nvim
```

Open up NeoVim and run:

```
:PackerCompile
:PackerInstall
```

## Usage

- Add new plugins to https://github.com/CaioBianchi/nvim/blob/main/lua/plugins.lua
  - Configure/Init/Setup those plugins @ https://github.com/CaioBianchi/nvim/blob/main/lua/settings.lua

- Add keystroke mappings to https://github.com/CaioBianchi/nvim/blob/main/lua/mappings.lua


## Updating

Updating plugins is as easy as running the following in NeoVim:

```
:PackerSync
```
