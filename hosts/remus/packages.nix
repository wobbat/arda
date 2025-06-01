{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (import ./packages/editors.nix {inherit pkgs inputs;})
    ++ (import ./packages/browsers.nix {inherit pkgs;})
    ++ (import ./packages/development.nix {inherit pkgs;})
    ++ (import ./packages/security.nix {inherit pkgs;})
    ++ (import ./packages/system-utils.nix {inherit pkgs;})
    ++ (import ./packages/wayland.nix {inherit pkgs;})
    ++ (import ./packages/terminal.nix {inherit pkgs;})
    ++ (import ./packages/fonts.nix {inherit pkgs;})
    ++ (import ./packages/dev-libs.nix {inherit pkgs;});
}
