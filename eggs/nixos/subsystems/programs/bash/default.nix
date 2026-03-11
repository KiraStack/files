{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFileSize = 100000;
    # initExtra = "";
    # bashrcExtra = "";
    shellOptions = [
      "autocd" # change to named directory
      "cdspell" # autocorrects cd misspellings
      "cmdhist" # save multi-line commands in history as single line
      "dotglob"
      "histappend" # do not overwrite history
      "expand_aliases" # expand aliases
      "checkwinsize" # checks term size when bash regains control
    ];
    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'';
    };
    shellAliases = {
      cdown = ''
        N=$1
        while [[ $((--N)) -gt  0 ]]
          do
            echo "$N" |  figlet -c | lolcat &&  sleep 1
        done
      '';
      cls = "clear";
    };
  };
}
