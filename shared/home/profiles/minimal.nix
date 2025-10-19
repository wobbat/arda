{ config, pkgs, ... }: {
  # Minimal home configuration for solo/remote systems
  
  imports = [
    ../fish.nix
    ../starship.nix  
    ../git.nix
    ../legacy/tmux.nix
  ];

  # Basic user info (will be overridden by mkHome helper)
  home.stateVersion = "24.05";

  # Enable home manager
  programs.home-manager.enable = true;
  
  # Enable bash for compatibility
  programs.bash.enable = true;
}