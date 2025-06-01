vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "_")
--vim.keymap.set("n", "J", "<C-d>zz")
--vim.keymap.set("n", "K", "<C-u>zz", { noremap = true })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>ftb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
-- Better redo
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "U", "<C-r>")

-- LEADER stuff
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fb", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- Show quick fix
vim.api.nvim_set_keymap('n', '<Leader>qf', ':copen<CR>', { noremap = true, silent = true })



-- Ctrl-w t to toggle Neo-tree
vim.keymap.set('n', '<C-w>t', function()
    require('neo-tree.command').execute({ toggle = true })
end, { silent = true, desc = 'Neo-tree: Toggle File Explorer' })


-- lsp?
-- Global LSP keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to Definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: Go to Implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: Show References' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover Documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: Rename Symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
vim.keymap.set('n', '<leader>sd', vim.diagnostic.open_float, { desc = 'LSP: Show Diagnostics' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'LSP: Prev Diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'LSP: Next Diagnostic' })
-- Toggle LSP diagnostics
_G.diagnostics_visible = true

vim.keymap.set("n", "<leader>tod", function()
    _G.diagnostics_visible = not _G.diagnostics_visible
    if _G.diagnostics_visible then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end, { desc = "Toggle diagnostics" })


-- in init.lua
vim.keymap.set('v', '<leader>yc', '"+y', { noremap = true, silent = true })

-- Give Neovim a shorter idle time (default is 4000ms)
-- vim.o.updatetime = 250
--
-- -- When you hold the cursor, open a non-focusable diagnostic window
-- vim.cmd [[
--   autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focus = false })
-- ]]


-- in your init.lua
vim.keymap.set(
    'n',
    '<leader>dl', -- e.g. \dl
    function()
        vim.diagnostic.setloclist({ open = true })
    end,
    { noremap = true, silent = true, desc = "Diagnostics → location list" }
)
vim.keymap.set("n", "<C-j>", "}", { desc = "Next block/paragraph" })
vim.keymap.set("n", "<C-k>", "{", { desc = "Prev block/paragraph" })
