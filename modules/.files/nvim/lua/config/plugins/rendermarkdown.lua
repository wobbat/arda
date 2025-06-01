-- in your plugins.lua (or wherever you call require('lazy').setup)
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },      -- only load in Markdown buffers
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    opts = {
      render_modes = true,
      anti_conceal = {
        enabled = true,
        ignore = {
          code_background = true,
          sign            = true,
        },
        above = 0,
        below = 0,
      },
      bullet = {
        enabled       = true,
        icons         = { '• ', '• ', '• ', '• ' },
        ordered_icons = function(level, index, value)
          value = vim.trim(value)
          local vi = tonumber(value:sub(1, #value - 1))
          return string.format('%d.', (vi and vi > 1) and vi or index)
        end,
        left_pad  = 1,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
      },
      enabled = true,
      checkbox = {
        position = 'inline',
        unchecked = {
          icon            = ' ',
          highlight       = 'RenderMarkdownUnchecked',
          scope_highlight = nil,
        },
        checked = {
          icon            = ' ',
          highlight       = 'RenderMarkdownChecked',
          scope_highlight = '@markup.strikethrough',
        },
        custom = {
          todo = {
            raw             = '[-]',
            rendered        = ' ',
            highlight       = 'RenderMarkdownTodo',
            scope_highlight = nil,
          },
        },
      },
      heading = {
        enabled        = true,
        position       = 'inline',
        icons          = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
        sign           = false,
        width          = 'full',
        left_margin    = 0,
        left_pad       = 0,
        right_pad      = 0,
        min_width      = 0,
        border         = true,
        border_virtual = false,
        border_prefix  = false,
        above          = '▄',
        below          = '▀',
        -- refer to the *group names* here, not raw hex
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
        foregrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        },
      },
    },
    config = function(_, opts)
      -- 1) setup the plugin
      require('render-markdown').setup(opts)

      -- 2) override the auto-generated groups with your hex colours
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1',             { fg = '#f4bf75', bg = '#7a603b', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg',           { fg = '#f4bf75', bg = '#7a603b', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2',             { fg = '#b46958', bg = '#5a352c', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH2Bg',           { fg = '#b46958', bg = '#5a352c', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3',             { fg = '#90A959', bg = '#48552d', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH3Bg',           { fg = '#90A959', bg = '#48552d', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4',             { fg = '#88afa2', bg = '#445851', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH4Bg',           { fg = '#88afa2', bg = '#445851', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5',             { fg = '#7e97ab', bg = '#3f4c56', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH5Bg',           { fg = '#7e97ab', bg = '#3f4c56', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6',             { fg = '#AA749F', bg = '#553a50', italic = false })
      vim.api.nvim_set_hl(0, 'RenderMarkdownH6Bg',           { fg = '#AA749F', bg = '#553a50', italic = false })
      vim.api.nvim_set_hl(0, 'markdownHeadingDelimiter',     { fg = '#727272', bg = '#202020', italic = false })

vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#f4bf75', bg = '#7a603b', italic = false })  -- H1
vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#b46958', bg = '#5a352c', italic = false })  -- H2
vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = '#90A959', bg = '#48552d', italic = false })  -- H3
vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = '#88afa2', bg = '#445851', italic = false })  -- H4
vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = '#7e97ab', bg = '#3f4c56', italic = false })  -- H5
vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = '#AA749F', bg = '#553a50', italic = false })  -- H6


        end,
  },
}

