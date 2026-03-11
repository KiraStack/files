{ hostname, ... }:
let
  inherit (import ../../hosts/${hostname}/variables.nix)
    timezone
    locale # system locale
    desktop
    terminal
    editor
    browser
    videoDriver # GPU driver
    kbdLayout
    kbdVariant
    consoleKeymap
    bluetoothSupport
    ;
in
{
  # GnuPG agent (cryptography)
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Display server
  services.xserver = {
    enable = true;
    xkb.layout = "${kbdLayout}";
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  # Locale
  time.timeZone = "${timezone}";
  i18n.defaultLocale = "${locale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${locale}";
    LC_IDENTIFICATION = "${locale}";
    LC_MEASUREMENT = "${locale}";
    LC_MONETARY = "${locale}";
    LC_NAME = "${locale}";
    LC_NUMERIC = "${locale}";
    LC_PAPER = "${locale}";
    LC_TELEPHONE = "${locale}";
    LC_TIME = "${locale}";
  };

  # System-wide environment
  environment.variables = rec {
    # XDG directories
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_BIN_HOME = "$HOME/.local/bin";

    # Package managers
    CARGO_BIN_PATH = "$HOME/.cargo/bin";
    PNPM_BIN = "$HOME/.local/share/pnpm";

    # Binaries
    PATH = [
      "${XDG_BIN_HOME}"
      "${CARGO_BIN_PATH}"
      "${PNPM_BIN}"
      "$HOME/.emacs.d/bin"
    ];

    # Cursors
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # Nix package management
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "archie" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # System version reference for upgrades.
  # Do not modify.
  system.stateVersion = "26.05";
}
