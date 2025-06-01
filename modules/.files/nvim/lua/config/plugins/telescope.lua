return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'folke/trouble.nvim',
    },
    keys = {
        '<leader>gs', '<leader>ds', '<leader>ws',
        '<leader>ff', '<leader>lg',
        '<leader>tb', '<leader>mg',
        { '<C-t>', mode = { 'n', 'i' } },
    },
    config = function()
        local telescope    = require('telescope')
        local builtin      = require('telescope.builtin')
        local themes       = require('telescope.themes')
        local action_state = require('telescope.actions.state')
        local pickers      = require('telescope.pickers')
        local finders      = require('telescope.finders')
        local make_entry   = require('telescope.make_entry')
        local conf         = require('telescope.config').values
        local ts_trouble   = require('trouble.sources.telescope')
        local actions      = require('telescope.actions')

        -- 1) Ivy helper: bottom-pane, 80% height, top prompt
        local ivy          = function(opts)
            opts = opts or {}
            return themes.get_ivy(vim.tbl_deep_extend("force", {
                layout_config = {
                    width           = { padding = 0 },
                    height          = { padding = 0 },
                    prompt_position = "top",

                },
                borderchars   = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                previewer     = true,
                prompt_title  = false,
                prompt_prefix = "# ",
                results_title = false,
            }, opts))
        end

        -- 2) telescope.setup with Ivy defaults + fzf extension
        telescope.setup {
            defaults = {
                layout_strategy = "bottom_pane",
                layout_config   = { height = 0.80, prompt_position = "top",
                    width  = { padding = 0 },
                    height = { padding = 0 },
                },
                prompt_prefix   = "❯ ",
                mappings        = {
                    i = { ["<C-t>"] = ts_trouble.open,
                        ["<C-;>"] = require("telescope.actions.layout").toggle_preview },
                    n = { ["<C-t>"] = ts_trouble.open },

                },
            },
            extensions = {
                fzf = {
                    fuzzy                   = true,
                    override_generic_sorter = true,
                    override_file_sorter    = true,
                    case_mode               = 'smart_case',
                },
            },
        }
        telescope.load_extension('fzf')

        -- 3) keymaps for all pickers using Ivy()

        vim.keymap.set('n', '<leader>gs', function()
            builtin.grep_string(ivy())
        end, {})

        vim.keymap.set('n', '<leader>ds', function()
            builtin.lsp_document_symbols(ivy())
        end, {})

        vim.keymap.set('n', '<leader>ws', function()
            builtin.lsp_workspace_symbols(ivy())
        end, {})

        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                find_command = { 'fd', '--type', 'f', '--hidden', '--follow' },
            })
        end, {})

        vim.keymap.set('n', '<leader>lg', function()
            builtin.live_grep(ivy())
        end, {})

        vim.keymap.set('n', '<leader>tb', function()
            builtin.buffers(vim.tbl_deep_extend("force",
                ivy {
                    initial_mode = 'normal',
                    attach_mappings = function(prompt_bufnr, map)
                        local delete_buf = function()
                            local current = action_state.get_current_picker(prompt_bufnr)
                            current:delete_selection(function(selection)
                                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                            end)
                        end
                        map('n', '<c-d>', delete_buf)
                        return true
                    end,
                },
                {
                    sort_lastused = true,
                    sort_mru      = true,
                }
            ))
        end, {})

        local live_multigrep = function(opts)
            opts = opts or {}
            opts.cwd = vim.fn.getcwd()
            local finder = finders.new_async_job {
                command_generator = function(prompt)
                    if not prompt or prompt == '' then return nil end
                    local parts = vim.split(prompt, ' ')
                    local pat   = parts[1]
                    local glob  = parts[2]
                    if glob and glob ~= '' then
                        if glob:match('^%*%.') then glob = '**/' .. glob end
                        return {
                            '/bin/bash', '-c',
                            string.format(
                                'rg --color=never --no-heading --with-filename --line-number --column --smart-case -e "%s" -g "%s"',
                                pat, glob
                            )
                        }
                    else
                        return {
                            '/bin/bash', '-c',
                            string.format(
                                'rg --color=never --no-heading --with-filename --line-number --column --smart-case -e "%s"',
                                pat
                            )
                        }
                    end
                end,
                entry_maker       = make_entry.gen_from_vimgrep(opts),
                cwd               = opts.cwd,
            }

            pickers.new(opts, {
                debounce     = 100,
                prompt_title = 'Multi Grep',
                previewer    = conf.grep_previewer(opts),
                sorter       = require('telescope.sorters').empty(),
                finder       = finder,
            }):find()
        end

        -- vim.keymap.set('n', '<leader>mg', function()
        --     live_multigrep(ivy {
        --         layout_config = {
        --             width         = { padding = 0 },
        --             height        = { padding = 0 },
        --             preview_width = 0.6,
        --         },
        --     })
        -- end, {})

        local actions_layout = require('telescope.actions.layout')

        vim.keymap.set('n', '<leader>ff', function()
            require('telescope.builtin').find_files {
                prompt_prefix = "# ",
                find_command  = { "fd", "--type", "f", "--hidden", "--follow" },
                layout_config = {
                    prompt_position = "bottom",
                    vertical        = { preview_width = 0.5 },
                    width           = { padding = 0 },
                    height          = { padding = 0 },
                },
                prompt_title  = false,
                borderchars   = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                previewer     = false,
                preview_title = false,
                results_title = false,
            }
        end, {})

        vim.keymap.set('n', '<leader>mg', function()
            live_multigrep {
                -- switch to a horizontal split layout:
                layout_strategy = "vertical",
                layout_config   = {
                    -- ratio of the preview window in the horizontal layout
                    vertical        = { preview_width = 0.5 },
                    -- overall size relative to the editor
                    width           = { padding = 0 },
                    height          = { padding = 0 },
                    prompt_position = "bottom",
                },
                prompt_title    = false,
                preview_title   = false,
                prompt_prefix   = "# ",
                results_title   = false,
                borderchars     = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            }
        end, {})

        -- 4) Helix-style highlights
        vim.cmd [[
      highlight! link TelescopeBorder         Normal
      highlight! link TelescopePromptBorder  Normal
      highlight! link TelescopePromptNormal  Normal
      highlight! link TelescopePromptPrefix  Normal
      highlight! link TelescopeMatching      Identifier
      highlight! link TelescopeSelection     Visual
    ]]
    end,
}
