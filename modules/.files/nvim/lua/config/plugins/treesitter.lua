-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',                   -- keep your parsers up-to-date
    event = { 'BufReadPost', 'BufNewFile' }, -- load when opening files
    opts = {
      ensure_installed = {
        "lua", "go", "rust", "c", "bash", "markdown",
        "vim", "vimdoc", "query", "zig", 'markdown_inline',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      auto_install = true,
    },
    config = function(_, opts)
      -- link your custom @headlines to the Identifier group
      vim.api.nvim_set_hl(0, "@headlines", { link = "Identifier" })

      -- now apply your Treesitter settings
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

