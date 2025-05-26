{
  config,
  pkgs,
  inputs,
  ...
}:
{

  imports = [ ];
  programs.nixvim.enable = true;
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        keymaps = {
          "<C-p>" = {
            action = "git_files";
            options = {
              desc = "Telescope Git Files";
            };
          };
          "<leader>fg" = "live_grep";
        };
      };
      lualine = {
        enable = true;
      };
    };
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "dim.nvim";
        version = "1.0";
        src = pkgs.fetchFromGitHub {
          owner = "wobbat";
          repo = "dim.nvim";
          rev = "4243de804ee3d57fcae62c258a275300fa4b65fd";
          hash = "sha256-phS2zgcO9frl2Fcv10Zb2eOgTs8e/amL9KszrJ4sCpE=";
        };
      })
    ];
    colorscheme = "dim";
    extraConfigLua = (builtins.readFile ./nvim.lua);

#  -- extra keymaps
# vim.g.mapleader = " "
# -- File manager
# vim.keymap.set("n", "<leader>fb", vim.cmd.Ex)
# vim.keymap.set("n", "L", "$")
#               vim.keymap.set("n", "H", "_")
#                   -- line numbers
#                   vim.opt.nu = true
#                   vim.opt.relativenumber = true
#                   -- Formatting
#                   vim.opt.tabstop = 4
#                   vim.opt.softtabstop = 4
#                   vim.opt.shiftwidth = 4
#                   vim.opt.expandtab = true
#                   vim.opt.smartindent = true
#                   vim.opt.list = true
#                   vim.opt.listchars = {
#                       space = "⋅",
#                       eol = "↴",
#                       tab = "▎_",
#                       -- tab = "|_>",
#                       trail = "•",
#                       extends = "❯",
#                       precedes = "❮",
#                       nbsp = "",
#                   }
#                   vim.opt.fillchars = {
#                       fold = " ",
#                       foldsep = " ",
#                       foldopen = "",
#                       foldclose = "",
#                       diff = "╱",
#                   }
#                   vim.opt.wrap = true
#                   vim.opt.swapfile = false
#                   vim.opt.backup = false
#                   vim.opt.undofile = true
#                   vim.opt.hlsearch = false
#                   vim.opt.incsearch = true
#                   vim.opt.scrolloff = 8
#                   vim.opt.cursorline = true
#                   vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none' })
#                   --Fix markdown fenced code blocks
#                   vim.cmd("let g:markdown_fenced_languages = ['html', 'php','python', 'javascript', 'js=javascript']")
#                   -- theme
#                   vim.opt.clipboard = "unnamedplus"
#                   vim.cmd("set signcolumn=no")
#                   --vim.opt.spelllang = 'en_us,nl'
#                   --vim.opt.spell = true
#                   vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ab8550' })
#                   vim.cmd("colorscheme dim")
#                   vim.o.scrolloff = 8;
#                   vim.o.cmdheight=0
#                   vim.cmd("let g:vim_markdown_frontmatter = 1")
#                   vim.cmd("let g:vim_markdown_toml_frontmatter = 1")
#                   vim.cmd("let g:vim_markdown_json_frontmatter = 1")
#                   ---- lualine
#                   require('lualine').setup {
#                       options = {
#                           icons_enabled = false,
#                           theme = 'auto',
#                           component_separators = { left = ' ', right = ' ' },
#                           section_separators = { left = ' ', right = ' ' },
#                           disabled_filetypes = {
#                               statusline = {},
#                               winbar = {},
#                           },
#                           ignore_focus = {},
#                           always_divide_middle = true,
#                           globalstatus = false,
#                           refresh = {
#                               statusline = 1000,
#                               tabline = 1000,
#                               winbar = 1000,
#                           }
#                       },
#                       sections = {
#                           lualine_a = { 'mode' },
#                           lualine_b = { 'branch', 'diagnostics' },
#                           lualine_c = { 'filename' },
#                           lualine_x = { "" },
#                           lualine_y = { 'diff' },
#                           lualine_z = { 'filename' }
#                       },
#                       inactive_sections = {
#                           lualine_a = {},
#                           lualine_b = {},
#                           lualine_c = { 'filename' },
#                           lualine_x = { 'location' },
#                           lualine_y = {},
#                           lualine_z = {}
#                       },
#                       tabline = {},
#                       winbar = {},
#                       inactive_winbar = {},
#                       extensions = {}
#                   }
#                   ----
#                   netrw
#                   -----------------------------------------------------------
#       -- Netrw configuration file
#       ----------------------------------------------------------
#       local g = vim.g
#       local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
#       local options_append = {
#           netrw_keepdir = 0,             --Keep the current directory and the browsing directory synced
#           netrw_winsize = "17",          -- 17% size
#           netrw_banner = "0",            -- hide banner
#           netrw_localmkdir = "mkdir -p", -- change mkdir cmd
#           netrw_localcopycmd = "cp -r",  -- change copy command
#           netrw_localrmdir = "rm -r",    -- change delete command
#           netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']],
#       }
#       for k, v in pairs(options_append) do
#           g[k] = v
#       end
#       autocmd("filetype", {
#           pattern = "netrw",
#           desc = "Better mappings for netrw",
#           callback = function()
#               local bind = function(lhs, rhs)
#                   vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
#               end
#               -- Navigation
#               bind("H", "u")                      -- preview dir
#               bind("h", "-^")                     -- go up
#               bind("l", "<CR>")                   -- open file or dir
#               bind(".", "gh")                     -- toggle dotfiles
#               bind("<leader>dd", ":Lexplore<CR>") -- close if open
#               -- Marks
#               bind("<TAB>", "mf")         -- toggle mark
#               bind("<S-TAB>", "mF")       -- unmark
#               bind("<leader><TAB>", "mu") -- unmark all
#               -- Files
#               bind("ff", ":!touch ")    -- create file
#               bind("fd", ":!mkdir -p ") -- create folder
#               bind("fm", ":!mv ")       -- move/rename
#               bind("fc", ":!cp -r ")    -- copy
#               bind("D", ":!rm -r ")     -- delete
#                     bind("f;", "mx")          -- run command
#                 end,
#             })
#     '';
  };
}
