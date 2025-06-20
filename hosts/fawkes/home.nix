{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home/profiles/awesome.nix
  ];

  # Host-specific packages
  home.packages = with pkgs; [
    # install pkgs for home here
  ];
}
