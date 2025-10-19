{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./packages.nix
    ../../shared/system/common.nix
    ../../shared/system/profiles/hyprland.nix
    ../../shared/system/llm.nix
  ];

  # Host-specific configuration
  networking.hostName = "smaug";
  services.tailscale.enable = true;

}
