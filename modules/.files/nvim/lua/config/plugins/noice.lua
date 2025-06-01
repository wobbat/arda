-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',  -- load on a lazy event; adjust as you like
    dependencies = {
      'MunifTanjim/nui.nvim',    -- required UI component library
--      'rcarriga/nvim-notify',    -- optional notification manager
    },
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          cmdline     = { icon = "#"    },
          search_down = { icon = "/"    },
          search_up   = { icon = "SU:"  },
          filter      = { icon = "$"    },
          lua         = { icon = "lua:" },
          help        = { icon = "?"    },
          border      = { style = "none" },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]                = true,
          ["cmp.entry.get_documentation"]                  = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search         = true,  -- classic bottom cmdline for search
        long_message_to_split = false, -- send long messages to a split
      },
    },
  },
}

