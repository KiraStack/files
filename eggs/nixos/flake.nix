# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  description = "None";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      mkSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            # Add an overlay
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  inputs.neovim-nightly-overlay.overlays.default
                ];
              }
            )

            # Include the results of the hardware scan.
            ./hardware-configuration.nix

            # Add home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users = {
                  archie = import ./hosts/archie.nix;
                };
              };
            }

            # Include the NixOS module
            ./hosts/home.nix
          ];
        };
    in
    {
      # Generate system config by hostname
      nixosConfigurations = {
        archie = mkSystem "archie";
      };
    };
}
