vim.cmd([[
    set autoindent expandtab tabstop=2 shiftwidth=2
    let mapleader = "\<Space>"
]])

local histon = require('histon')
vim.keymap.set('n', '<leader>fd', histon, {})

