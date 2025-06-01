local function get_relative_path()
    local cwd = vim.fn.getcwd()               -- Current working directory
    local last_part = cwd:match("([^/\\]+)$") -- Match the last part after the last slash
    local rel_path = vim.fn.expand('%:.')     -- Full path of the current file
    local final_path = last_part .. "/" .. rel_path
    return final_path
end

function Whopy2()
    -- Get the selected text's line numbers
    local start_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
    local end_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Get the line number of the first line in the selection
    local linenr = start_line

    -- Join lines and surround with <figure>, <pre>, and <figcaption> tags
    local text_to_copy = string.format([[
<figure linenr="%d">
  <pre>%s</pre>
  <figcaption>%s</figcaption>
</figure>
]], linenr, table.concat(lines, "\n"), get_relative_path())

    -- Copy to clipboard
    vim.fn.setreg('+', text_to_copy)
    print("Text copied to clipboard with <figure> tag, <pre> tag, and relative file path!")
end

function Whopy()
    -- Get the selected text's line numbers
    local start_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
    local end_line, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Get the line number of the first line in the selection
    local linenr = start_line

    -- Join lines and trim whitespace
    local text_to_copy = table.concat(lines, "\n")
    text_to_copy = text_to_copy:match("^%s*(.-)%s*$") -- Trim leading and trailing whitespace

    -- Surround with <figure>, <pre>, and <figcaption> tags
    text_to_copy = string.format([[
<figure linenr="%d">
  <pre>%s</pre>
  <figcaption>%s</figcaption>
</figure>
]], linenr, text_to_copy, get_relative_path())

    -- Copy to clipboard
    vim.fn.setreg('+', text_to_copy)
    print("Text copied to clipboard with <figure> tag, <pre> tag, and relative file path!")
end

vim.api.nvim_set_keymap('v', '<Leader>whc', ':lua Whopy()<CR>', { noremap = true, silent = true })
