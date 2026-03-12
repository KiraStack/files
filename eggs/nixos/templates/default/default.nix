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
    # packages = with pkgs; [ ];
    shellHook = ''
      echo "Hello, world!"
    '';
  }
