{
  inputs,
  hostname,
  pkgs,
  ...
}:
let
  inherit (import ../../hosts/${hostname}/variables.nix)
    timezone
    locale
    desktop
    terminal
    editor
    browser
    shell
    videoDriver
    clock24h
    kbdLayout
    kbdVariant
    consoleKeymap
    bluetoothSupport
    ;
in
{
  # Load home-manager
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  # Manage GNOME/GTK settings
  programs.dconf.enable = true;

  # Manage user configurations
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "backup";

    # User session management
    users.${hostname} = {
      home = {
        username = "${hostname}";
        homeDirectory = "/home/${hostname}";
        stateVersion = "26.05"; # nixOS version reference for upgrades.
        sessionVariables = rec {
          EDITOR =
            if (editor == "nixvim" || editor == "neovim" || editor == "nvchad") then
              "nvim"
            else if editor == "vscode" then
              "code"
            else
              "nano";
          BROWSER = "${browser}";
          TERMINAL = "${terminal}";
        };
      };
      programs.home-manager.enable = true; # let home-manager manage itself
      xdg.enable = true;
    };
  };

  # Local user accounts
  users = {
    mutableUsers = true;
    users.${hostname} = {
      isNormalUser = true;
      description = "Personal user account";
      extraGroups = [
        # User privileges (via groups)
        "wheel" # sudo access
        "input"
        "networkmanager"
        "video"
        "audio"
        "libvirtd"
        "kvm"
        "docker"
        "disk"
        "adbusers"
        "lp"
        "scanner"
        "vboxusers" # virtual box
      ];
      shell = pkgs.${shell};
      createHome = true;
      initialPassword = ""; # use user-defined or hashed password
    };
  };

  # Nix defaults
  nix.settings.allowed-users = [ "${hostname}" ];
}
