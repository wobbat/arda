vim.cmd('colorscheme dim')
-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
-- Formatting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.list = true

--pretty whitespace and git chars
vim.opt.listchars = {
    space = " ",
    eol = " ",
    tab = "|·",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "",
}

vim.opt.fillchars = {
    fold = " ",
    foldsep = " ",
    foldopen = "",
    foldclose = "",
    diff = "╱",
}

vim.opt.cursorline = false

vim.api.nvim_set_hl(0, "WinSeparator", {
    fg = "#44475a", -- darker gray (adjust to your liking)
    bg = "NONE",
    bold = true,
})

vim.opt.fillchars:append { vert = " " } -- or "┃", "▌"
