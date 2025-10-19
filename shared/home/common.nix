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
  home.file.".wallpapers".source = pkgs.lib.fileset.toSource {
    root = ../../../resources/.files/wallpapers;
    fileset = pkgs.lib.fileset.fromSource (pkgs.lib.sources.sourceByRegex ../../../resources/.files/wallpapers [".*"]);
  };
  home.file.".wallpapers".recursive = true;
  
  home.file.".config/rofi".source = pkgs.lib.fileset.toSource {
    root = ../../../resources/.files/rofi;
    fileset = pkgs.lib.fileset.fromSource (pkgs.lib.sources.sourceByRegex ../../../resources/.files/rofi [".*"]);
  };
  home.file.".config/rofi".recursive = true;

  home.file.".config/nvim".source = pkgs.lib.fileset.toSource {
    root = ../../../resources/.files/nvim;
    fileset = pkgs.lib.fileset.fromSource (pkgs.lib.sources.sourceByRegex ../../../resources/.files/nvim [".*"]);
  };
  home.file.".config/nvim".recursive = true;

  # Enable home manager
  programs.home-manager.enable = true;
}