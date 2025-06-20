{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home/profiles/hyprland.nix
  ];

  # Host-specific packages
  home.packages = with pkgs; [
    # install pkgs for home here
  ];
}
