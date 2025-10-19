{ config, pkgs, ... }: {
  # Common home configuration shared across all hosts
  
  # Default state version (can be overridden by host configurations)
  home.stateVersion = "24.05";
  
  # Pointer cursor configuration
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  # Common imports
  imports = [
    ./fish.nix
    ./helix.nix
    ./starship.nix
    ./git.nix
  ];

  # Common file configurations
  home.file.".wallpapers".source = builtins.path {
    path = ../../../resources/.files/wallpapers;
    name = "wallpapers";
  };
  home.file.".wallpapers".recursive = true;
  
  home.file.".config/rofi".source = builtins.path {
    path = ../../../resources/.files/rofi;
    name = "rofi";
  };
  home.file.".config/rofi".recursive = true;

  home.file.".config/nvim".source = builtins.path {
    path = ../../../resources/.files/nvim;
    name = "nvim";
  };
  home.file.".config/nvim".recursive = true;

  # Enable home manager
  programs.home-manager.enable = true;
}