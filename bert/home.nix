{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./home/hyprland.nix
    ./home/fish.nix
    ./home/starship.nix
    ./home/alacritty.nix
    ./home/git.nix
    ./home/nixvim.nix
  ];

  home.username = "wobbat";
  home.homeDirectory = "/home/wobbat";
  

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 8;
    # "Xft.dpi" = 172;
  };

   home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 24;
    };

  #   programs.nixvim = {
  #   # This just enables NixVim.
  #   # If all you have is this, then there will be little visible difference
  #   # when compared to just installing NeoVim.
  #   enable = true;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    eza
    #security
    nmap

    #gui
    waybar
    libnotify
    dunst
    wbg

    #utils
    file
    which
    btop
    iotop
    iftop
    #other
    discord
    signal-desktop
    nixfmt-rfc-style
    pavucontrol

    #test
    inconsolata
    gnomeExtensions.forge
  ];

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
