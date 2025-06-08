return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'},
        opts = {
            renderers = {
                file = {
                    {"indent"}, -- { "icon" },
                    {
                        "container",
                        content = {
                            {"name", zindex = 10},
                            {
                                "symlink_target",
                                zindex = 10,
                                highlight = "NeoTreeSymbolicLinkTarget"
                            }, {"clipboard", zindex = 10},
                            {"bufnr", zindex = 10},
                            {"diagnostics", zindex = 20, align = "right"},
                            {"git_status", zindex = 10, align = "right"}
                        }
                    }
                }
            },
            close_if_last_window = true,
            popup_border_style = 'rounded',
            enable_git_status = false,
            enable_diagnostics = false,
            open_files_do_not_replace_types = {
                'terminal', 'Trouble', 'qf', 'edgy'
            },
            filesystem = {
                bind_to_cwd = true,
                cwd_target = {sidebar = 'window', current = 'tab'},
                window = {mappings = {["<tab>"] = "toggle_node"}},
                components = {
                    icon = function(config, node, state)
                        if node.type == 'file' then
                            local bufnr = vim.fn.bufnr(node.path, false)
                            local is_loaded = (bufnr > 0 and
                                                  vim.api
                                                      .nvim_buf_is_loaded(bufnr))
                            local sign = is_loaded and '* ' or '• '
                            return {text = sign, highlight = config.highlight}
                        end
                        return
                            require('neo-tree.sources.common.components').icon(
                                config, node, state)
                    end
                },
                follow_current_file = true,
                hijack_netrw_behavior = 'open_default', -- Open Neotree on directory open
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = true
                }
            },
            default_component_configs = {
                indent = {indent_size = 2, padding = 0},
                icon = {
                    folder_closed = '[+]',
                    folder_open = '[-]',
                    folder_empty = '[o]',
                    default = '*'
                },
                git_status = {
                    symbols = {
                        added = '',
                        modified = '',
                        deleted = '',
                        renamed = '',
                        untracked = ''
                    }
                },
                file_size = {
                    enabled = false,
                    width = 12, -- width of the column
                    required_width = 64 -- min width of window required to show this column
                },
                type = {
                    enabled = false,
                    width = 10, -- width of the column
                    required_width = 122 -- min width of window required to show this column
                },
                last_modified = {
                    enabled = false,
                    width = 20, -- width of the column
                    required_width = 88 -- min width of window required to show this column
                },
                created = {
                    enabled = true,
                    width = 20, -- width of the column
                    required_width = 110 -- min width of window required to show this column
                },
                symlink_target = {enabled = false},
                -- Disable the file type icons
                file = {
                    icon = false -- Disable file type icons
                }
            },
            window = {
                position = "float", -- Open as floating window by default
                width = 50 -- Adjust the width of the floating window
            }
        },
        config = function(_, opts)
            require('neo-tree').setup(opts)

            local neotree_cmd = require('neo-tree.command').execute
            local last_win

            -- Toggle open/close, and remember last non-tree window
            vim.keymap.set('n', '<C-a>', ':NeoTreeFloatToggle<CR>',
                           {noremap = true, silent = true})

            -- Set the keymap for <leader>v to open Neotree on the left
            vim.keymap.set('n', '<leader>v', function()
                if vim.bo.filetype == 'neo-tree' and last_win and
                    vim.api.nvim_win_is_valid(last_win) then
                    vim.api.nvim_set_current_win(last_win)
                else
                    last_win = vim.api.nvim_get_current_win()
                    -- Open Neotree on the left side with a fixed width
                    neotree_cmd({position = 'left', width = 30, focus = true})
                end
            end, {desc = 'Neo-tree: Toggle Focus Explorer on the Left'})
        end
    }
}

