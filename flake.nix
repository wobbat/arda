{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://helix.cachix.org" ];
    extra-trusted-public-keys = [ "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix/master";
    # Personal package repository - reserved for future custom packages
    wbp.url = "github:wobbat/wobbix_packages";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:wobbat/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    let
      lib = import ./lib/mkSystem.nix { inherit nixpkgs home-manager; };
      homeLib = import ./lib/mkHome.nix { inherit nixpkgs home-manager; };
    in
    {
      nixosConfigurations = {
        hugin = lib.mkSystem {
          hostname = "hugin";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/hugin/main.nix ];
          homeModules = [ ./hosts/hugin/home.nix ];
        };
        
        remus = lib.mkSystem {
          hostname = "remus";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/remus/main.nix ];
          homeModules = [ ./hosts/remus/home.nix ];
        };
        
        fawkes = lib.mkSystem {
          hostname = "fawkes";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/fawkes/main.nix ];
          homeModules = [ ./hosts/fawkes/home.nix ];
        };
      };
      homeConfigurations = {
        "wobbat@solo" = homeLib.mkHome {
          username = "wobbat";
          homeDirectory = "/home/wobbat";
          stateVersion = "24.05";
          modules = [
            ./hosts/solo/home.nix
          ];
        };
      };
    };
}
