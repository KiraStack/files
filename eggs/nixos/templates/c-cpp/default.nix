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
    packages =
      with pkgs;
      [
        # Compiler & tooling
        clang-tools # Clang-related tools for code analysis
        gnumake # Standard build tool
        # cmake # Build system generator

        # Code quality
        codespell # Spellchecking in source code
        cppcheck # Static code analysis

        # Package management
        conan # C/C++ package manager
        vcpkg # C/C++ package manager
        vcpkg-tool # CLI for vcpkg

        # Testing & coverage
        gtest # Unit testing framework
        lcov # Code coverage tool

        # Documentation
        doxygen # Docs generator
      ]
      ++ (if system != "aarch64-darwin" then [ gdb ] else [ ]); # GDB excluded on Apple Silicon

    shellHook = ''
      echo "Hello, world!"
    '';
  }
