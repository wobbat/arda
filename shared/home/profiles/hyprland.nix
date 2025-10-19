{ config, pkgs, lib, ... }: {
  # Hyprland-specific home configuration
  
  imports = [
    ../common.nix
    ../hyprland.nix
    ../wezterm.nix
  ];

  # Chromium with Wayland support
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=WaylandWindowDecorations"  
        "--force-device-scale-factor=1.5"
      ];
    };
  };

  # Hyprland-specific rofi config (override common)
  home.file.".config/rofi" = lib.mkForce {
    source = pkgs.lib.fileset.toSource {
      root = ../../../resources/.files/rofi_lr;
      fileset = pkgs.lib.fileset.fromSource (pkgs.lib.sources.sourceByRegex ../../../resources/.files/rofi_lr [".*"]);
    };
    recursive = true;
  };
}