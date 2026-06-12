require('nvim-treesitter').setup {}

-- require('nvim-treesitter').install { 'c', 'cpp', 'odin' }
require('nvim-treesitter').install { 'c', 'cpp' }

vim.api.nvim_create_autocmd('FileType', {
    -- pattern = { 'c', 'cpp', 'odin' },
    pattern = { 'c', 'cpp' },
    callback = function() vim.treesitter.start() end,
})
