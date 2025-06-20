{ config, pkgs, ... }: {
  # Common home configuration shared across all hosts
  
  # Basic user info
  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";
  home.stateVersion = "23.11";

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
  home.file.".wallpapers".source = ../.files/wallpapers;
  home.file.".wallpapers".recursive = true;
  
  home.file.".config/rofi".source = ../.files/rofi;
  home.file.".config/rofi".recursive = true;

  home.file.".config/nvim".source = ../.files/nvim;
  home.file.".config/nvim".recursive = true;

  # Enable home manager
  programs.home-manager.enable = true;
}