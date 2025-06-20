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
  ];

  # Host-specific configuration
  networking.hostName = "remus";
  
  # VMware host configuration
  virtualisation.vmware.host.enable = true;
}
