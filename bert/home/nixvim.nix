{
  programs.nixvim.enable = true;
  programs.nixvim = {
    colorschemes.kanagawa.enable = true;
    colorscheme = "kanagawa";
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
    };
  };
}
