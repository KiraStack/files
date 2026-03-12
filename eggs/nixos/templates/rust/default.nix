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
      clippy
      # rustc  # replaced by shellHook via rustup
      # cargo  # replaced by shellHook via rustup
      rustup
      rustfmt
    ];
    shellHook = ''
      echo "Hello, world!"
      rustup toolchain install nightly
      rustup default nightly
    '';
  }
