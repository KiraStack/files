{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "amdgpu" ]; # use open-source AMD driver

  # AMD packages
  environment.systemPackages = with pkgs; [
    rocmPackages.amdsmi # AMD GPU monitoring tool
  ];

  # Machine configurations
  hardware = {
    graphics.enable = true;
  };
}
