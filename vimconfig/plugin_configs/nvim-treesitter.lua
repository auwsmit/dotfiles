-- disabled
-- if 1 then return end

if not vim.fn.has('nvim') then
    return
end

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "python", "c", "cpp" },
    highlight = { enable = true },
    indent = { enable = false },
}

-- CUSTOM TREE SITTER SYNTAX
-- =========================
-- Note: this is for Bad Wolf to look more like it did in Vim

-- Vim and C
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"vim", "c"},
    callback = function()
        -- no highlighting variables
        vim.api.nvim_set_hl(0, '@variable', {})
        vim.api.nvim_set_hl(0, '@variable.parameter', {})
    end,
})

-- Vim
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"vim"},
    callback = function()
        -- no highlighting function macros
        vim.api.nvim_set_hl(0, '@function.macro', {})
    end,
})

-- C
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cpp"},
    callback = function()
        -- highlight builtin types, e.g. char, int, void etc
        vim.api.nvim_set_hl(0, '@type.builtin', { link = 'Type' })
        -- no highlighting struct members
        vim.api.nvim_set_hl(0, '@property', {})
        -- no highlighting struct member declarations
        vim.api.nvim_set_hl(0, '@variable.member', {})
    end,
})

-- Set comma, period, and square brackets to be highlighted as operators
-- ---------------------------------------------------------------------
-- By default, comma and period are highlight group @punctuation.delimiter
-- By default square bracket, parenthesis, and curly brackets are hl group @punctuation.bracket
vim.treesitter.query.set('c', 'highlights', [[
;; extends
(["," "." "[" "]"]) @operator
]])

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"lua"},
    callback = function()
        -- no highlighting table members
        vim.api.nvim_set_hl(0, '@variable.member', {})
    end,
})
