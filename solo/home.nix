{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
           ../solo/alacritty.nix
           ../shared/home/starship.nix
           ../shared/home/fish.nix
           ../shared/home/git.nix
           ../shared/home/tmux.nix
  ];


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    eza
    nixfmt-rfc-style
  ];
  
  # trying this to see if the vars are set correctly?
  programs.bash.enable = true;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
