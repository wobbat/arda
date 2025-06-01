return {
    {
        "folke/trouble.nvim",
        cmd    = "Trouble", -- lazy‐load when the :Trouble command or mappings are used
        keys   = {
            -- toggle the last opened Trouble view
            {
                "<leader>tt",
                "<cmd>TroubleToggle<CR>",
                desc = "Trouble: toggle last view",
            },
            -- toggle diagnostics for the *current* buffer only
            {
                "<leader>td",
                function()
                    require("trouble").toggle("diagnostics", {
                        skip_groups = true,
                        jump        = true,
                        filter      = { buf = 0 },
                    })
                end,
                desc = "Trouble: buffer diagnostics",
            },
            -- toggle all workspace diagnostics
            {
                "<leader>tw",
                function()
                    require("trouble").toggle("diagnostics", {
                        skip_groups = true,
                        jump        = true,
                    })
                end,
                desc = "Trouble: workspace diagnostics",
            },
        },
        config = function()
            require("trouble").setup({
            })
        end,
    },
}
