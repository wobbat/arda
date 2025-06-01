-- Global “format on save” group
local fmt_grp = vim.api.nvim_create_augroup("GlobalLspFormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group    = fmt_grp,
    pattern  = "*", -- or restrict e.g. {"*.js","*.lua",…}
    callback = function()
        local bufnr   = vim.api.nvim_get_current_buf()
        -- use the new API instead of the deprecated vim.lsp.get_active_clients()
        local clients = vim.lsp.get_clients({ bufnr = bufnr }) -- :contentReference[oaicite:0]{index=0}

        for _, client in ipairs(clients) do
            if client.server_capabilities.documentFormattingProvider then
                -- sync so save waits for formatting
                vim.lsp.buf.format({ async = false })
                return
            end
        end
        -- no formatting-capable client attached → do nothing
    end,
})
