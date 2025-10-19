{ config, pkgs, inputs, ... }: {
  # =============================================================================
  # BASIC SYSTEM CONFIGURATION
  # =============================================================================

  nixpkgs.config.allowUnfree = true;

  # Nix configuration
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    settings = {
      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-users = [ "root" "wobbat" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  boot.loader.systemd-boot.configurationLimit = 5;

  # System version
  system.stateVersion = "25.05";

  # =============================================================================
  # NETWORKING AND HARDWARE
  # =============================================================================

  networking.networkmanager.enable = true;

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
  
  # Enable nix-ld for running non-Nix executables
  programs.nix-ld.enable = true;

  # =============================================================================
  # Flatpack
  # =============================================================================

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "gtk";

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

  # Enable fish globally
  programs.fish.enable = true;
}