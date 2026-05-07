# japanese-input-nvim

A neovim plugin to make Japanese input a bit simpler on MacOS. Primarily aimed
at English speakers who plan to write in Japanese occasionally.

By default, the plugin behavior works like this:

Use `<leader>ij` to prime Japanese Input when you next enter insert. If you
don't enter insert within 3 seconds, its automatically unprimed to avoid
accidentally entering Japanese Input. Whenever you exit insert mode, the plugin
enable English Input.


## Dependencies

By default, requires [macism](https://github.com/laishulu/macism).

## Options

| Name| Description| Default |
|-----|------------|-- |
| `key` | The input key you want to prime Japanese Input. | `<leader>ij`|
| `command` | The command that should be run by the plugin to switch inputs. | `macism`|
| `english_ime`| The name of the English input method. | `com.apple.keylayout.US`|
| `japanese_ime` | The name of the Japanese input method. | `com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese`|


## Usage

You can use this repo as a regular neovim plugin using your preferred
package manager.

<details>
    <summary>lazy.nvim</summary>

```lua
{
"skyethepinkcat/japanese-input-nvim", lazy = false,
},
```

    I have not tested this with lazy loading, but I don't see any reason it
    shouldn't work.
</details>


### Nixvim

If you use [nixvim](https://github.com/nix-community/nixvim) and flake-parts, a nixvim module
has already been provided for you.

flake.nix:
```nix
{
    inputs = {
        japanese-input-nvim.url = "github:skyethepinkcat/nvim"
    }
}

```
