-- disabled
-- if 1 then return end

if not vim.fn.has('nvim') then
    return
end

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "python", "c", "cpp" },
    highlight = { enable = true },
    indent = { enable = true },

    -- CUSTOM TREE SITTER SYNTAX
    -- =========================

    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"vim", "c"},
        callback = function()
            -- no highlighting variables
            vim.api.nvim_set_hl(0, '@variable', {})
            vim.api.nvim_set_hl(0, '@variable.parameter', {})
        end,
    }),
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"vim"},
        callback = function()
            -- no highlighting function macros
            vim.api.nvim_set_hl(0, '@function.macro', {})
        end,
    }),
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"c"},
        callback = function()
            -- highlight builtin types
            vim.api.nvim_set_hl(0, '@type.builtin', { link = 'Type' })
        end,
    })
}
