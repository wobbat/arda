{
  config,
  pkgs,
  inputs,
  ...
}:
{

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vscode
    inputs.helix.packages."${pkgs.system}".helix
    git
    unzip
    firefox
    firefox-beta-bin
    xfce.thunar
    xfce.thunar-archive-plugin
    wget
    python3
    jetbrains-mono
    dtrx
    hermit
    nixfmt-rfc-style
    google-chrome
    wofi # App launcher for Wayland
    wl-clipboard # Clipboard utilities for Wayland
    grim # Screenshot utility for Wayland
    slurp # Screen area selection for Wayland
    wezterm # Terminal emulator (as configured in Hyprland)
    swaybg # Background setter for Wayland
    zoxide
    steam-run
    mesa
    (pkgs.burpsuite.override { proEdition = true; })

  ];

}
