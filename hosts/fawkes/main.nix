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
    ../../shared/system/profiles/awesome.nix
  ];

  # Host-specific configuration
  networking.hostName = "fawkes";
  
  # VMware guest configuration
  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  # Host-specific user packages
  users.users.wobbat.packages = with pkgs; [
    ly
    (pkgs.burpsuite.override { proEdition = true; })
  ];
}
