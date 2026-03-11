{ pkgs, ... }:
{
  # Host-specific packages.
  # Edit as needed.
  environment.systemPackages = with pkgs; [
    # git # version control
    # curl # data transfer from URLs
    # wget # download files
    # tree # show directory structure
  ];
}
