{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../shared/home/profiles/hyprland.nix
  ];

  # Host-specific packages
  home.packages = with pkgs; [
    # install pkgs for home here
  ];
}
