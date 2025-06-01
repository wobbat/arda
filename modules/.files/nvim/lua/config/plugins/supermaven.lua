-- lua/plugins/supermaven.lua
return {
    "supermaven-inc/supermaven-nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<C-l>", -- or choose your own
                clear_suggestion = "<C-]>",
                accept_word = "<C-j>",
                accept_line = "<C-k>",
            },
            disable_inline_completion = false,
            disable_keymaps = false,
        })
    end,
}
