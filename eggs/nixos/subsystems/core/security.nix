{ ... }:
{
  services.gnome.gnome-keyring.enable = true; # manage passwords and keys (gnome)
  security = {
    rtkit.enable = true; # real-time scheduling support
    protectKernelImage = true;
    acme.acceptTerms = true; # accept ACME-based CA terms
  };
}
