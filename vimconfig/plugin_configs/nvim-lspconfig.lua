-- disabled
-- if 1 then return end

if not vim.fn.has('nvim') then return end

-- enable LSPs
vim.lsp.enable('ols')    -- for Odin
vim.lsp.enable('clangd') -- for C

-- disable diagnostics (not specific to LSPs, but I dont use any diagnostics beyond :make atm)
vim.diagnostic.enable(false)

-- disable LSP semantic highlighting
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
})
