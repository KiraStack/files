{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Networking configuration
  networking = {
    hostName = "archie";
    networkmanager.enable = true;
  };

  # User definition
  users.users.archie = {
    isNormalUser = true;
    description = "Personal user account";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
    ];
    createHome = true;
    password = ""; # Do not store passwords in plain text; set manually or use hashed passwords
  };

  # Fonts installed system-wide
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code
  ];

  # Remove unnecessary preinstalled packages
  environment.defaultPackages = [ ];

  # System packages grouped with comments
  environment.systemPackages = with pkgs; [
    # Programming
    clang-tools
    eslint_d
    fzf
    gcc
    git
    lua-language-server
    nodejs_25
    nixfmt
    prettierd
    pyright
    python3
    rustup
    typescript

    # Code editors
    vscode

    # Core
    clipcat
    xclip
    xdg-utils

    # File management
    file-roller
    ranger
    ripgrep
    unzip

    # Media
    cava
    mpv
    steam
    vesktop

    # Window management
    eww
    hsetroot
    kitty
    overskride
    picom
    rofi
    sxhkd

    # System monitors
    dunst
    htop

    # Portals
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];

  # Nixpkgs configuration
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
      ];
    pulseaudio = true;
  };

  # Programs
  programs = {
    # Fish shell
    fish.enable = true;

    # Neovim editor
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Firefox browser configuration
    firefox = {
      enable = true;
      languagePacks = [
        "en-GB"
        "en-US"
      ];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";
        SearchBar = "unified";

        # Extensions / add-ons
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # Block all other add-ons
          "jid1-BoFifL9Vbdl2zQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{74145f27-f039-47ce-a470-a662b129930a}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
            installation_mode = "force_installed";
          };
          "sponsorBlocker@ajay.app" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            installation_mode = "force_installed";
          };
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "enhanced-h264ify@unrelenting.technology" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/latest.xpi";
            installation_mode = "force_installed";
          };
          "dfyoutube@example.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/df-youtube/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            # Bitwarden
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        # Firefox preferences locked
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = {
            Value = false;
            Status = "locked";
          };
          "extensions.screenshots.disabled" = {
            Value = true;
            Status = "locked";
          };
          "browser.topsites.contile.enabled" = {
            Value = false;
            Status = "locked";
          };
          "browser.formfill.enable" = {
            Value = false;
            Status = "locked";
          };
          "browser.search.suggest.enabled" = {
            Value = false;
            Status = "locked";
          };
          "browser.search.suggest.enabled.private" = {
            Value = false;
            Status = "locked";
          };
          "browser.urlbar.suggest.searches" = {
            Value = false;
            Status = "locked";
          };
          "browser.urlbar.showSearchSuggestionsFirst" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.feeds.section.topstories" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.feeds.snippets" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.showSponsored" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.system.showSponsored" = {
            Value = false;
            Status = "locked";
          };
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = {
            Value = false;
            Status = "locked";
          };
        };
      };
    };

    # OBS Studio
    obs-studio = {
      enable = true;
      package = (pkgs.obs-studio.override { cudaSupport = true; });
      plugins = with pkgs.obs-studio-plugins; [
        # wlrobs # Wayland support
        # obs-backgroundremoval
        # obs-pipewire-audio-capture
        # obs-vaapi # AMD hardware acceleration
        # obs-vkcapture # Vulkan hardware acceleration
      ];
    };
  };

  # Services
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        bg = "0x00000000";
        fg = "0x00FFFFFF";
        border_fg = "0x00FFFFFF";
        error_fg = "0x00FF0000";
        clock_color = "0x00FFFFFF";
      };
    };
    pipewire.enable = false;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      extraConfig = "load-module module-combine-sink";
    };
    xserver = {
      enable = true;
      xkb.layout = "gb";
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      windowManager = {
        bspwm.enable = true;
      };
    };
    picom.enable = true;
    flatpak.enable = true;
  };

  # Hardware configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
    graphics.enable = true;
  };

  # Per-user environment variables
  environment.sessionVariables = rec {
    # Programs
    SHELL = "${pkgs.fish}/bin/fish";
    TERMINAL = "kitty";
    MANPAGER = "nvim +Man!";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";

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
  };

  # XDG settings and MIME applications
  xdg = {
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };

    # Default applications for files and links
    mime.defaultApplications = {
      # Documents
      "text/plain" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/pdf" = "firefox.desktop";
      "image/*" = "mpv.desktop";
      "audio/*" = "mpv.desktop";
      "video/*" = "mpv.desktop";
      "application/zip" = "file-roller.desktop";

      # Links
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/mailto" = "firefox.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
    };
  };

  # Boot settings
  boot = {
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  # Nix settings
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

  # Time
  time.timeZone = "Europe/London";

  # Locale
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Security
  security = {
    rtkit.enable = true;
    protectKernelImage = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  system.stateVersion = "25.11";
}
