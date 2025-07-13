{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./packages.nix
    ../../modules/system/common.nix
    ../../modules/system/profiles/hyprland.nix
    ../../modules/system/llm.nix
  ];

  # Host-specific configuration
  networking.hostName = "odin";
  services.tailscale.enable = true;

}
