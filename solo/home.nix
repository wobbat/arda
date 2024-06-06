{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
           ../shared/home/alacritty.nix
           ../shared/home/starship.nix
           ../shared/home/fish.nix
           ../shared/home/git.nix
  ];


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    rxvt-unicode
    vscode
    eza
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
