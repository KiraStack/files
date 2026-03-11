{ pkgs, ... }:
{
  # Window manager
  services.xserver.windowManager.bspwm.enable = true;

  # Picom compositor
  services.picom = {
    enable = true;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    sxhkd # Hotkey daemon
  ];
}
