{
  config,
  pkgs,
  inputs,
  ...
}: 
let
  lib = import ../../lib/mkPackages.nix { inherit pkgs inputs; };
in
{
  environment.systemPackages = lib.mkPackages lib.profiles.desktop;
}
