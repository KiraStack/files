{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    package = (pkgs.obs-studio.override { cudaSupport = true; });
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs # Wayland support
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # AMD hardware acceleration
      obs-vkcapture # Vulkan hardware acceleration
    ];
  };
}
