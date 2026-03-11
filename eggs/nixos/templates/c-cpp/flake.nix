{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, ... }@inputs:
    let
      # Systems this flake can generate configs for
      systems = [
        "x86_64-linux" # Standard 64-bit Linux
        "aarch64-linux" # ARM 64-bit Linux
        "x86_64-darwin" # 64-bit macOS
        "aarch64-darwin" # ARM 64-bit macOS (Apple Silicon)
      ];

      # Generate system-specific configurationss
      forEachSupportedSystem =
        callback:
        inputs.nixpkgs.lib.genAttrs systems (
          system: callback { pkgs = import inputs.nixpkgs { inherit system; }; }
        );
    in
    {
      templates = forEachSupportedSystem (
        { pkgs, system }:
        {
          default =
            pkgs.mkShell.override
              {
                # Override stdenv in order to change compiler:
                # stdenv = pkgs.clangStdenv;
              }
              {
                packages =
                  with pkgs;
                  [
                    clang-tools # Clang-related tools
                    make # cmake # Build system
                    codespell # Spellcheck
                    conan # Package manager
                    cppcheck # Static analysis
                    doxygen # Docs generator
                    gtest # Unit tests
                    lcov # Code coverage
                    vcpkg # Package manager
                    vcpkg-tool # Vcpkg CLI
                  ]
                  ++ (if system != "aarch64-darwin" then [ gdb ] else [ ]);
              };
        }
      );
    };
}
