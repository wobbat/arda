-- Function to open a floating terminal in the center of the screen
local function open_floating_terminal()
    -- Get the dimensions of the editor
    local ui = vim.api.nvim_list_uis()[1]
    local width = math.floor(ui.width * 0.8)
    local height = math.floor(ui.height * 0.8)
    local col = math.floor((ui.width - width) / 2)
    local row = math.floor((ui.height - height) / 2)

    -- Create the floating window with a terminal buffer
    local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
    })

    -- Set the buffer to terminal mode
    vim.fn.termopen(vim.o.shell) -- Open the terminal using the default shell
    vim.api.nvim_command('startinsert') -- Start in insert mode

    -- Optionally set the window to close with <q>
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
end

-- Call the function
vim.api.nvim_create_user_command("FloatTerm", function()
    open_floating_terminal()
end, {})

