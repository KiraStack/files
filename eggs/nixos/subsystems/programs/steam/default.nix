{ ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # steam remote play
    dedicatedServer.openFirewall = true; # source dedicated server
    localNetworkGameTransfers.openFirewall = true; # local network game transfers
  };
}
