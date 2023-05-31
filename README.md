# pulapula.nvim
## Setup

```lua
vim.keymap.set('n', '<C-h>', require('pulapula').move_left)
vim.keymap.set('n', '<C-l>', require('pulapula').move_right)
vim.keymap.set('n', '<C-k>', require('pulapula').move_up)
vim.keymap.set('n', '<C-j>', require('pulapula').move_down)
vim.keymap.set('n', '<C-w>o', require('pulapula').maximize)

```

Por padrão o Neovim vai respeitar o zoom das panes. Caso queira alterar esse comportamento basta setar a variável `vim.g.pulapula_ignore_zoom` para `true`
