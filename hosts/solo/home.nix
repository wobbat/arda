{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home/profiles/minimal.nix
  ];

  # Host-specific packages
  home.packages = with pkgs; [
    eza
    nixfmt-rfc-style
    semgrep
    inconsolata-nerdfont
  ];
}
