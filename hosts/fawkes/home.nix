{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/home/wezterm.nix
    ../../modules/home/fish.nix
    ../../modules/home/helix.nix
    ../../modules/home/starship.nix
    ../../modules/home/git.nix
  ];

  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  # Packages that should be installed to the user profile.``
  home.packages = with pkgs; [
    # install pkgs for home here
  ];

  programs.chromium = {
    enable = true;
  };

  # legacy dots
  home.file.".config/rofi".source = ../../modules/.files/rofi;
  home.file.".config/rofi".recursive = true;

  home.file.".config/nvim".source = ../../modules/.files/nvim;
  home.file.".config/nvim".recursive = true;

  home.file.".config/awesome".source = ../../modules/.files/awesome;
  home.file.".config/awesome".recursive = true;

  # This value determines the home Manager release that your2
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
