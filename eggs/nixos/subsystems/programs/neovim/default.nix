{ ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.sessionVariables = rec {
    # use Neovim for editing
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };
}
