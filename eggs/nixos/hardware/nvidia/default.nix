{
  lib,
  pkgs,
  config,
  ...
}:
{
  services.xserver.videoDrivers = [ "nouveau" ]; # use open-source NVIDIA driver

  # Machine configurations
  hardware = {
    nvidia = {
      open = false;
      powerManagement.enable = true; # enable sleep/suspend support
      modesetting.enable = true; # required for proper display output
      package = nvidiaDriverChannel;
    };
    graphics = {
      # VA-API/VDPAU packages
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };

  # NixOS package configurations
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "cudatoolkit" # CUDA toolkit package
        "nvidia-persistenced" # NVIDIA persistence daemon package
        "nvidia-settings" # NVIDIA settings GUI package
        "nvidia-x11" # NVIDIA X11 driver package
      ];
  };
}
