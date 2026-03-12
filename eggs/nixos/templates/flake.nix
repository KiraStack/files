{
  description = "A simple flake for templates";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      # Supported systems
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # Generate system-specific attributes
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system: rec {
        # Reusable import arguments
        args = { inherit system nixpkgs; };

        # Barebones template
        default = import ./default args;

        # C/C++ template
        # c = import ./c-cpp args;
        # cpp = import ./c-cpp args;
        c-cpp = import ./c-cpp args;

        # NixOS template
        nix = import ./nix args;

        # Python template
        python = import ./python args;

        # Rust template
        rust = import ./rust args;

        # Aliases
        c = c-cpp;
        cpp = c-cpp;
      });
    };
}
