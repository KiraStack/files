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
    ani-cli # watch anime in terminal
    cava # audio visualizer
    clipcat # Wayland clipboard
    cmus # terminal music player
    curl # data transfer from URLs
    dunst # notifications
    eww # widget system
    file-roller # archive manager GUI
    git # version control
    hsetroot # wallpaper setter
    htop # interactive process viewer
    kitty # GPU-accelerated terminal
    maim # screenshot tool
    mpv # media player
    neovim # terminal editor
    nixfmt # nix (code) formatter
    overskride # bluetooth (gui)
    playerctl # control media players
    ranger # terminal file manager
    ripgrep # fast recursive search
    rofi # application launcher
    slop # select screen region
    tree # show directory structure
    unzip # extract .zip archives
    vscode # Visual Studio Code editor
    wget # download files
    xclip # X11 clipboard CLI
    xdg-desktop-portal # portal backend
    xdg-desktop-portal-gnome # GNOME portal backend
    xdg-desktop-portal-gtk # GTK implementation
    xdg-desktop-portal-wlr # wlroots portal backend
    xdg-utils # desktop integration tools
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
