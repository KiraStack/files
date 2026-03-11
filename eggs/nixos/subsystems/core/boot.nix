{ ... }:
{
  boot = {
    tmp = {
      cleanOnBoot = true;
    };
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = null; # keep bootloader until selection
    };
  };
}
