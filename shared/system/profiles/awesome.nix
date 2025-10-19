{ config, pkgs, ... }: {
  # =============================================================================
  # AWESOME WM DESKTOP PROFILE (X11)
  # =============================================================================

  # Import base desktop configuration
  imports = [
    ../desktop.nix
  ];

  # X11 and AwesomeWM configuration
  services.xserver.enable = true;
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      # add any lua packages required by your configuration here
    ];
  };

  services.displayManager = {
    defaultSession = "none+awesome";
  };

  # Display manager configuration
  services.displayManager.ly = {
    enable = true;
    settings = {
      default_user = "wobbat";
      remember = false;
    };
  };

  # Boot configuration (GRUB for legacy systems)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
}