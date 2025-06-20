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
  home.file.".config/awesome".source = ../../.files/awesome;
  home.file.".config/awesome".recursive = true;
}