{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://helix.cachix.org" ];
    extra-trusted-public-keys = [ "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix/master";
    wbp.url = "github:wobbat/wobbix_packages";
    zenbrowser.url = "github:0xc000022070/zen-browser-flake";
    zenbrowser.inputs.nixpkgs.follows = "nixpkgs";
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
        remus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./hosts/remus/main.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wobbat.imports = [
                ./hosts/remus/home.nix
              ];

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        fawkes = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./hosts/fawkes/main.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wobbat.imports = [
                ./hosts/remus/home.nix

              ];

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
            inputs.nixvim.homeManagerModules.nixvim

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
