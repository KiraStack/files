{ pkgs, ... }:
{
  # Host-specific packages.
  # Edit as needed.
  environment.systemPackages = [
    pkgs.libc
    pkgs.llvmPackages.lldb
  ];
}
