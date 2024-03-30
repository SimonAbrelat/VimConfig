# Neovim Configuration

For this I am building off [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [the Primeagen's config](https://github.com/ThePrimeagen/init.lua) with a couple flairs of my own.

My goal for this is to have a fairly minimal config, no fancy splash screen for example, but to get modern editting through things like treesitter and LSP integration. While those tools are by no means small, and there are occasional slowdowns, the experience is meant to try and keep out of the way.

The main package which helps to keep my setup very basic is Mini.nvim, it has a set of core utilities which are very minimal by design.
Mini.nvim is used for:
- Colorschemes
- Around/inside textobjects
- Surround
- Highlights
- Statusbar
- Comments

I am using `<SPACE>` as the leader key, which is nicer than I had initially given it credit for, and rose-pine for my theme.

## Major Packages
- Mini.nvim 
- Telescope
- Treesitter
- Nvim-lsp
