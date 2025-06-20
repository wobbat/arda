{ config, pkgs, ... }: {
  # =============================================================================
  # HYPRLAND DESKTOP PROFILE
  # =============================================================================

  # Import base desktop configuration
  imports = [
    ../desktop.nix
  ];

  # Enable Hyprland and Wayland
  programs = {
    hyprland.enable = true;
    xwayland.enable = true;
  };

  # Environment variables for Wayland
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.5"; # Adjust scale for HiDPI displays
  };

  # Boot configuration (systemd-boot for UEFI systems)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}