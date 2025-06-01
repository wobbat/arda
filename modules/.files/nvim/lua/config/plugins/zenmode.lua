-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        backdrop = 1,
        width    = 0.65,
        height   = 0.99,
        options  = {
          signcolumn = "yes",
        },
      },
    },
    keys = {
      {
        "<leader>zm",
        function() require("zen-mode").toggle() end,
        desc = "Zen Mode: Toggle"
      },
    },
  },
}

