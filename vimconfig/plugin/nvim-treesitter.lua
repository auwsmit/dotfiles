local ok, mod = pcall(require, 'nvim-treesitter')

if ok then
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "vim", "lua", "python", "c", "cpp" },
        highlight = { enable = true },
        indent = { enable = true },
    }
end
