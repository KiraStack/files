{ ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Default to [n]vim
  environment.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };
}

# let
#   nvim = nixvim.legacyPackages.x86_64-linux.makeNixvim {
#     plugins = {};
#   };
# in pkgs.mkShell {
#   buildInputs = [nvim];
# };
