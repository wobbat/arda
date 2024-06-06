{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix/master";
    wbp.url = "github:wobbat/wobbix_packages";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    {
      nixosConfigurations = {
        bert = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./bert/main.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              #home-manager.users.wobbat = import ./bert/home.nix;
              home-manager.users.wobbat.imports = [
                ./bert/home.nix
                inputs.nixvim.homeManagerModules.nixvim
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        ernie = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./ernie/main.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wobbat = import ./ernie/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    homeConfigurations = {
     "wobbat@solo" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [
           ./bert/home/alacritty.nix
           ./bert/home/starship.nix
           ./bert/home/fish.nix
           ./solo/home.nix
          {
            home.username = "wobbat";
            home.homeDirectory = "/home/wobbat";
            home.stateVersion = "24.05";
            nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
          }
        ];
      };
    };
      
    };
}
