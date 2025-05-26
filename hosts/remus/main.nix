# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports =
    [ # Include the results of the hardware scan.
      # ./hardware.nix  # Generate this with: nixos-generate-config
      ./packages.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "remus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  #VM
  virtualisation.vmware.guest.enable = true;


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable Wayland and Hyprland
  programs.hyprland.enable = true;
  
  # Enable XWayland for X11 app compatibility
  programs.xwayland.enable = true;
  
  # Enable polkit for authentication
  security.polkit.enable = true;
  #  services.xserver.desktopManager.plasma6.enable = true;


  # Configure keymap for Wayland
  console.keyMap = "us";
  
  # Optional: Keep X11 keymap for XWayland apps
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.wobbat = {
    isNormalUser = true;
    description = "stan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    # Wayland essentials
    wofi            # Application launcher (replaces rofi for Wayland)
    wezterm         # Terminal (as specified in your hyprland config)
    swaybg          # Background setter (already in your hyprland config)
    brightnessctl   # Brightness control
    playerctl       # Media control
    wpctl           # Audio control (part of pipewire)
    
    # Your existing packages
    htop
    feh
    ];
  };

  # Install firefox.
  # programs.firefox.enable = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Audio support for Wayland
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Remove X11 video drivers (not needed for Wayland)
  # services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  boot.kernelParams = [
    "i915.force_probe=a7a1"  
    "i915.enable_psr=0"
    ];


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
