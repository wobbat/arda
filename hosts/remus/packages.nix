{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (import ../../modules/packages/editors.nix {inherit pkgs inputs;})
    ++ (import ../../modules/packages/browsers.nix {inherit pkgs;})
    ++ (import ../../modules/packages/development.nix {inherit pkgs;})
    ++ (import ../../modules/packages/security.nix {inherit pkgs;})
    ++ (import ../../modules/packages/system-utils.nix {inherit pkgs;})
    ++ (import ../../modules/packages/wayland.nix {inherit pkgs;})
    ++ (import ../../modules/packages/terminal.nix {inherit pkgs;})
    ++ (import ../../modules/packages/fonts.nix {inherit pkgs;})
    ++ (import ../../modules/packages/dev-libs.nix {inherit pkgs;});
}
