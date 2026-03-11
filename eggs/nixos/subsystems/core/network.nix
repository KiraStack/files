{ hostname, ... }:
{
  # Networking
  networking = {
    hostName = "${hostname}";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Kernel
  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_ecn" = 1;
      "net.ipv4.tcp_fastopen" = 3;
    };
  };

  # Systemd tweaks
  systemd.services."NetworkManager-wait-online".enable = false;
  systemd.network.wait-online.enable = false;
}
