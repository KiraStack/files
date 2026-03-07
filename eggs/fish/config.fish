if status is-interactive
    # Picker
    alias grep 'grep --color=auto'

    # Lists
    alias l 'ls  -CF --color=auto --group-directories-first'
    alias la 'ls -AF --color=auto --group-directories-first'
    alias ll 'ls -alF --color=auto --group-directories-first'

    # Git
    alias gs 'git status'
    alias gd 'git diff'
    alias gl 'git log --oneline --graph --decorate'

    # Nix
    alias nix-store-ls "nix-store -qR"
    alias nix-collect "sudo nix-collect-garbage -d"
    alias nix-optimise "nix-store --optimise"
    alias nix-update "sudo nix flake update nixpkgs --flake /etc/nixos"
    alias nix-rebuild "sudo nixos-rebuild switch --flake /etc/nixos#(hostname)"
    alias nix-rebuild-rollback "sudo nixos-rebuild switch --rollback"

    # Prompt
    function fish_prompt
        echo -n (set_color $fish_color_cwd)
        echo -n (prompt_pwd)
        echo -n (set_color normal)
        echo -n " "
    end

    # List directory contents after changing into it.
    function cd
        builtin cd $argv && ls -CF --color=auto --group-directories-first
    end

    # Go up a specified number of directories.
    function up
        # Get amount
        set value (math "floor($argv[1])" 2>/dev/null)
        if test -z "$value" -o $value -lt 1 -o $value -gt 10
            set value 1
        end

        # Build path
        set path (string repeat -n $value "../")

        # Change directory
        if cd $path
            set dir (pwd)
            if test $dir = "/"
                set dir "ROOT"
            end
            echo "Current directory: $dir"
        else
            echo "Failed to go up $value dir(s)"
            return 1
        end
    end

    # Show the most used commands.
    function toppy
        history | awk '{CMD[$2]++; count++} END { for (a in CMD) print CMD[a] " " CMD[a]/count*100 "% " a }' \
            | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 21
    end
end
