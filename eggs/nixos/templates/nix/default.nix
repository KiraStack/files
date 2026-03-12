{ nixpkgs, system }:

let
  pkgs = import nixpkgs { inherit system; };
in
pkgs.mkShell.override
  {
    # Override stdenv if needed
    # stdenv = pkgs.clangStdenv;
  }
  {
    packages = with pkgs; [
      nixd
      cachix
      lorri
      niv
      nixfmt-classic
      statix
      vulnix
      haskellPackages.dhall-nix
    ];
    shellHook = ''
      echo "Hello, world!"
    '';
  }
