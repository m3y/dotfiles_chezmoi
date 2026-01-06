vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap

keymap.set('n', '<ESC><ESC>', ':<C-u>set nohlsearch!<CR>', { silent = true })

keymap.set('n', 'j', 'gj', { noremap = true })
keymap.set('n', 'k', 'gk', { noremap = true })
keymap.set('n', '<Down>', 'gj', { noremap = true })
keymap.set('n', '<Up>', 'gk', { noremap = true })
