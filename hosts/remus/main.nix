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
  networking.hostName = "remus";
  
  # VMware host configuration
  virtualisation.vmware.host.enable = true;
}
