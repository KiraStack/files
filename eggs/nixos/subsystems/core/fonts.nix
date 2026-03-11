{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true; # enable user font directory
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true; # smooth fonts
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Mono"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif"
          "DejaVu Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
