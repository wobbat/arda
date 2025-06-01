return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        opts = {
            close_if_last_window            = true,
            popup_border_style              = 'rounded',
            enable_git_status               = true,
            enable_diagnostics              = false,
            open_files_do_not_replace_types = {
                'terminal', 'Trouble', 'qf', 'edgy',
            },
            filesystem                      = {
                bind_to_cwd           = true,
                cwd_target            = { sidebar = 'window', current = 'tab' },
                window                = {
                    mappings = {
                        ["<tab>"] = "toggle_node",
                    },
                },
                components            = {
                    icon = function(config, node, state)
                        if node.type == 'file' then
                            local bufnr     = vim.fn.bufnr(node.path, false)
                            local is_loaded = (bufnr > 0 and vim.api.nvim_buf_is_loaded(bufnr))
                            local sign      = is_loaded and '* ' or '• '
                            return { text = sign, highlight = config.highlight }
                        end
                        return require('neo-tree.sources.common.components').icon(config, node, state)
                    end,
                },
                follow_current_file   = true,
                hijack_netrw_behavior = 'open_default',
                filtered_items        = {
                    visible         = false,
                    hide_dotfiles   = false,
                    hide_gitignored = true,
                },
            },
            default_component_configs       = {
                indent = { indent_size = 2, padding = 0 },
                icon = {
                    folder_closed = '[+]',
                    folder_open   = '[-]',
                    folder_empty  = '[o]',
                    default       = '*',
                },
                git_status = {
                    symbols = {
                        added     = 'A',
                        modified  = 'M',
                        deleted   = 'D',
                        renamed   = 'R',
                        untracked = 'U',
                    },
                },
            },
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)

            local neotree_cmd = require('neo-tree.command').execute
            local last_win

            -- -- Toggle open/close, and remember last non-tree window
            -- vim.keymap.set('n', '<C-h>', function()
            --     local cur = vim.api.nvim_get_current_win()
            --     if vim.bo.filetype ~= 'neo-tree' then
            --         last_win = cur
            --     end
            --     neotree_cmd({ toggle = true })
            -- end, { desc = 'Neo-tree: Toggle Explorer' })
            --
            -- Toggle focus: jump into the tree or back to previous window
            vim.keymap.set('n', '<C-a>', ':NeoTreeFloatToggle<CR>', { noremap = true, silent = true })

            vim.keymap.set('n', '<leader>v', function()
                if vim.bo.filetype == 'neo-tree'
                    and last_win
                    and vim.api.nvim_win_is_valid(last_win)
                then
                    vim.api.nvim_set_current_win(last_win)
                else
                    last_win = vim.api.nvim_get_current_win()
                    neotree_cmd({ focus = true })
                end
            end, { desc = 'Neo-tree: Toggle Focus Explorer' })
        end,
    },
}
