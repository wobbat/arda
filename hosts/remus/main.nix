{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware.nix
    ./packages.nix
  ];

  nix.settings.substituters = [
    "https://cache.nixos.org"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "remus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

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
  services.flatpak.enable = true;

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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # Wayland essentials
      rofi # Application launcher (replaces rofi for Wayland)
      wezterm # Terminal (as specified in your hyprland config)
      swaybg # Background setter (already in your hyprland config)

      # Your existing packages
      htop
      feh
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Audio support for Wayland
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1.5"; # Adjust this value to your desired scale (e.g. 1.25, 1.5, 2)
  };

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
