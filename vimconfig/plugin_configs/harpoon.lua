if vim.fn.has('nvim') then -- currently disabled
-- if not vim.fn.has('nvim') then -- enabled
    return
end

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<space>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<c-e>",    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-1>",    function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-2>",    function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-3>",    function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-4>",    function() harpoon:list():select(4) end)
vim.keymap.set("n", "<C-5>",    function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-6>",    function() harpoon:list():next() end)
