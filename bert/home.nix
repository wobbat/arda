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
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    eza

    #security
    nmap

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

    #test
    inconsolata
  ];

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
