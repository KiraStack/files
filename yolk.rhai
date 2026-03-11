// Constants
let os = #{ linux: SYSTEM.platform == "Linux", windows: SYSTEM.platform == "Windows", darwin: SYSTEM.platform == "Darwin" };
let home = io::env("HOME", "");
let localData = io::env("LOCALAPPDATA", "");

// Handle directories
private fn dir_exists(p) {
    io::path_exists(p) && io::path_is_dir(p)
}

// Handle files
private fn file_exists(p) {
    io::path_exists(p) && !io::path_is_dir(p)
}

// Merge into home
fn hmerge(templates) {
    #{
        targets: io::env("HOME", ""),
        enabled: true,
        strategy: "merge",
        templates: templates,
    }
}

// Eggs
export const eggs = #{
    nixos: #{
        targets: "/etc/nixos",
        enabled: os.linux,
        templates: [], // copied as is
    },
    xinitrc: hmerge(["xinitrc"]),
    bin: #{
        targets: home + "/.local/bin",
        enabled: os.linux,
        templates: [], // copied as is
    },
    bspwm: #{
        targets: home + "/.config/bspwm",
        enabled: os.linux,
        templates: [], // copied as is
    },
    cava: #{
        targets: home + "/.config/cava",
        enabled: os.linux,
        templates: [], // copied as is
    },
    dunst: #{
        targets: home + "/.config/dunst",
        enabled: os.linux,
        templates: [], // copied as is
    },
    eww: #{
        targets: home + "/.config/eww",
        enabled: os.linux,
        templates: [], // copied as is
    },
    fish: #{
        targets: home + "/.config/fish",
        enabled: os.linux || os.darwin,
        templates: [], // copied as is
    },
    hypr: #{
        enabled: false,
    },
    kitty: #{
        targets: home + "/.config/kitty",
        enabled: os.linux,
        templates: [], // copied as is
    },
    picom: #{
        targets: home + "/.config/picom",
        enabled: os.linux,
        templates: [], // copied as is
    },
    rofi: #{
        targets: home + "/.config/rofi",
        enabled: os.linux,
        templates: [], // copied as is
    },
    sxhkd: #{
        targets: home + "/.config/sxhkd",
        enabled: os.linux,
        templates: [], // copied as is
    },
    /*
    nvim: #{
        targets: if os.linux {
            home + "/.config/nvim"
        } else if os.darwin {
            home + "/.config/nvim"
        } else if os.windows {
            localData + "/nvim"
        } else {
            home + "/.config/nvim"
        },
        enabled: false,
        templates: [], // copied as is
    },
    */
};
