{ pkgs, lib, ... }:
{
  # NixOS package configurations
  nixpkgs.config = {
    allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
      ];
    pulseaudio = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    git # version control
    curl # data transfer from URLs
    wget # download files
    htop # interactive process viewer
    neovim # terminal editor
    nixfmt # nix (code) formatter
    tree # show directory structure
    unzip # extract .zip archives
    vscode # Visual Studio Code editor
    ripgrep # fast recursive search
    playerctl # control media players
    ani-cli # watch anime in terminal
    ranger # terminal file manager
    file-roller # archive manager GUI
    mpv # media player
    cmus # terminal music player
    cava # audio visualizer
    maim # screenshot tool
    slop # select screen region
    kitty # GPU-accelerated terminal
    rofi # application launcher
    eww # widget system
    hsetroot # wallpaper setter
    clipcat # Wayland clipboard
    dunst # notifications
    overskride # Bluetooth GUI
    xclip # X11 clipboard CLI
    xdg-utils # desktop integration tools
    xdg-desktop-portal # portal backend
    xdg-desktop-portal-gtk # GTK implementation
    xdg-desktop-portal-gnome # GNOME portal backend
    xdg-desktop-portal-wlr # wlroots portal backend
  ];

  # XDG settings and MIME applications
  xdg = {
    # Inter-process communication services
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
      # Links
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/mailto" = "firefox.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";

      # Files
      "text/plain" = "nvim.desktop";
      "text/html" = "firefox.desktop";
      "text/pdf" = "firefox.desktop";
      "image/*" = "mpv.desktop";
      "audio/*" = "cmus.desktop"; # "mpv.desktop";
      "video/*" = "mpv.desktop";
      "application/zip" = "file-roller.desktop";
    };
  };
}
