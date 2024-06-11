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
           ../shared/home/tmux.nix
           ../shared/nixvim/nixvim.nix
  ];


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    eza
    nixfmt-rfc-style
    semgrep
    inconsolata-nerdfont
  ];
  
  # trying this to see if the vars are set correctly?
  programs.bash.enable = true;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
