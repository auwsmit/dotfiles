require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "python", "c", "cpp" },
    highlight = { enable = true },
    indent = { enable = true },
}
