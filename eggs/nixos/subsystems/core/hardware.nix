{ hostname, ... }:
let
  inherit (import ../../hosts/${hostname}/variables.nix) bluetoothSupport;
in
{
  hardware = {
    bluetooth = {
      enable = bluetoothSupport;
      powerOnBoot = bluetoothSupport;
      settings.General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
