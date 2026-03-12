# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  description = "A simple flake for an atomic system";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-utils = { url = "github:numtide/flake-utils"; };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim"; # "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      # Systems this flake can generate configs for
      systems = [
        "x86_64-linux" # Standard 64-bit Linux
        "aarch64-linux" # ARM 64-bit Linux
        "x86_64-darwin" # 64-bit macOS
        "aarch64-darwin" # ARM 64-bit macOS (Apple Silicon)
      ];

      # Generate system-specific configurations
      forAllSystems = nixpkgs.lib.genAttrs systems;
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = forAllSystems (system: system);
          modules = [ ./hosts/${hostname}/configuration.nix ];
          specialArgs = {
            overlays = import ./overlays { inherit inputs hostname; };
            inherit
              self
              inputs
              hostname
              ;
          };
        };
    in
    {
      templates = import ./templates;
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      nixosConfigurations = {
        archie = mkHost "archie";
      };
    };
}
