{ inputs, ... }:
{
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  # additions = target: old: import ./pkgs { pkgs = target; inherit hostname; };

  # Changes
  # See: https://wiki.nixos.org/wiki/Overlays
  modifications = target: old: {
    # stable = import inputs.nixpkgs-stable {
    #   system = final.stdenv.hostPlatform.system;
    #   config.allowUnfree = true;
    # };
    discord = old.discord.override {
      withVencord = true;
      withOpenASAR = true;
      enableAutoscroll = true;
    };
  };
}
