-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
  {
    'echasnovski/mini.nvim',
    version = false,              -- use latest `main`
    event   = 'BufReadPost',      -- load after you open a buffer
    config  = function()
      -- trim & highlight trailing whitespace
      require('mini.trailspace').setup()
            vim.keymap.set("n", "<leader>mts", function()
                MiniTrailspace.trim()
        end)
    end,
  },
}

