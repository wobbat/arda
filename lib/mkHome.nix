{ home-manager, nixpkgs, ... }: {
  # Helper function to create home-manager configurations
  mkHome = {
    username,
    homeDirectory,
    stateVersion ? "24.05",
    modules ? [],
    extraSpecialArgs ? {},
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        {
          home.username = username;
          home.homeDirectory = homeDirectory; 
          home.stateVersion = stateVersion;
          
          # Standard home manager settings
          nixpkgs.config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
          
          programs.home-manager.enable = true;
        }
      ] ++ modules;
      extraSpecialArgs = extraSpecialArgs;
    };
}