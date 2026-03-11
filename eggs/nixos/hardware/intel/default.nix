{ pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ]; # generic kernel-based driver for most GPUs

  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
}
