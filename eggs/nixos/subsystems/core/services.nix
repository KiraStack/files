{ ... }:

{
  # SSD trim
  services.fstrim.enable = true;

  # SSH server
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false; # disable remote X11 apps
      PermitRootLogin = "prohibit-password";
    };
  };

  # Bluetooth
  services.blueman.enable = true;

  # Display manager
  services.displayManager.ly.enable = true;

  # Audio
  services.pipewire.enable = false; # disable conflicting pkg
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraConfig = "load-module module-combine-sink";
  };
}
