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
  ];

  # Host-specific configuration
  networking.hostName = "durin";

  boot.blacklistedKernelModules = [ "mtk_t7xx" ];

}
