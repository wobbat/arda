{
  config,
  pkgs,
  inputs,
  ...
}: {
  # =============================================================================
  # BASIC SYSTEM CONFIGURATION
  # =============================================================================

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware.nix
    ./packages.nix
  ];

  # Nix configuration
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # =============================================================================
  # BOOT AND SYSTEM
  # =============================================================================

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # System version
  system.stateVersion = "25.05";

  # =============================================================================
  # NETWORKING AND HARDWARE
  # =============================================================================

  networking = {
    hostName = "remus";
    networkmanager.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # =============================================================================
  # LOCALIZATION
  # =============================================================================

  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  # =============================================================================
  # DESKTOP ENVIRONMENT (WAYLAND/HYPRLAND)
  # =============================================================================

  programs = {
    hyprland.enable = true;
    xwayland.enable = true;
    fish.enable = true;
  };

  # Keyboard configuration
  console.keyMap = "us";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };

  # Environment variables for Wayland
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.5"; # Adjust scale for HiDPI displays
  };

  # =============================================================================
  # AUDIO
  # =============================================================================

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # =============================================================================
  # SECURITY AND SERVICES
  # =============================================================================

  security.polkit.enable = true;
  services.flatpak.enable = true;

  # =============================================================================
  # USER MANAGEMENT
  # =============================================================================

  users.users.wobbat = {
    isNormalUser = true;
    description = "stan";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # User-specific packages can be added here
    ];
  };

  # =============================================================================
  # FIREWALL 
  # =============================================================================

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
