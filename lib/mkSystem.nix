{ nixpkgs, home-manager, ... }:

{
  # Helper function to create NixOS system configurations with home-manager integration
  mkSystem = {
    hostname,
    system ? "x86_64-linux",
    specialArgs ? {},
    modules ? [],
    homeModules ? [],
    homeUser ? "wobbat",
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      
      specialArgs = specialArgs;
      
      modules = modules ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${homeUser}.imports = homeModules;
        }
      ];
    };
}