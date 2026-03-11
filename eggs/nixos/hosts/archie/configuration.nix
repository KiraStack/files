{ inputs, ... }:
let
  inherit (import ./variables.nix)
    desktop
    videoDriver
    browser
    editor
    shell
    terminal
    ;
in
{
  imports = [
    ./hardware-configuration.nix
    ./host-packages.nix
    ../../subsystems/core
    ../../subsystems/programs/${browser}
    ../../subsystems/programs/${editor}
    ../../subsystems/programs/vscode # temporary (used as debug tool).
    ../../subsystems/desktop/${desktop}
    ../../hardware/${videoDriver}
    ../../subsystems/programs/${shell}
    ../../subsystems/programs/${terminal}
    ../../subsystems/programs/discord
    ../../subsystems/programs/mangohud
    ../../subsystems/programs/neovim
    ../../subsystems/programs/obs-studio
    ../../subsystems/programs/starship
    ../../subsystems/programs/steam
  ];
}
