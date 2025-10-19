{ config, pkgs, ... }: {
  # AwesomeWM-specific home configuration
  
  imports = [
    ../common.nix
    ../wezterm.nix
  ];

  # Basic chromium for X11
  programs.chromium = {
    enable = true;
  };

  # AwesomeWM configuration
  home.file.".config/awesome".source = config.lib.fileset.toSource {
    root = ../../../resources/.files/awesome;
    files = config.lib.fileset.fromSource (pkgs.lib.sources.sourceByRegex ../../../resources/.files/awesome [".*"]);
  };
  home.file.".config/awesome".recursive = true;
}