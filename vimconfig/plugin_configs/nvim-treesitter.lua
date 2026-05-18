-- disabled
-- if 1 then return end

if not vim.fn.has('nvim') then
    return
end

-- require 'nvim-treesitter'.install { "lua", "python", "c", "cpp", "odin" }
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = { "lua", "python", "c", "cpp", "odin" },
--     callback = function() vim.treesitter.start() end,
-- })

-- still using the ol archived 2025 version
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "python", "c", "cpp", "odin" },
    highlight = {
        enable = false,
        disable = { "odin" },
    },
    indent = { enable = false },
}

