let
  # Import package set
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable";
  pkgs = import nixpkgs {
    config = { };
    overlays = [
      (target: old: {
        script = prev.writeTextFile {
          name = "script";
          text = ''
            #! ${pkgs.runtimeShell}
            echo "Hello, $USER!"
          '';
          executable = true;
          destination = "/bin/script";
        };
      })
    ];
  };
in

pkgs.mkShellNoCC {
  # Programs
  packages = with pkgs; [
    git
    script
  ];

  # Environment variable
  # DEBUG = 1;

  # Run on shell start
  shellHook = ''
    script
  '';
}
