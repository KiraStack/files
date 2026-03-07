#!/bin/sh
# Hyprland hyprpaper script with auto-setup

# Constants
WALL_DIR="$HOME/Pictures/Wallpapers"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
DEFAULT_WALL="$WALL_DIR/default.png"

# Create base directory if it doesn't exist
if [ ! -d "$WALL_DIR" ]; then
    mkdir -p "$WALL_DIR"
fi

# Create fallback image if none exist
if ! find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | grep -q .; then
    convert -size 1920x1080 xc:"#1e1e2e" "$DEFAULT_WALL" 2>/dev/null
fi

# Ensure hyprlock config exists
if [ ! -f "$HYPRLOCK_CONF" ]; then
    mkdir -p "$(dirname "$HYPRLOCK_CONF")"
    echo "background {
    path = $DEFAULT_WALL
    blur_passes = 2
}" > "$HYPRLOCK_CONF"
fi

# Create dropdown menu (using rofi)
chosen=$(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) \
    | sort \
    | rofi -dmenu -i -p "Select Wallpaper")

# Set hyprland background
if [ -n "$chosen" ]; then
    hyprctl hyprpaper preload "$chosen"
    hyprctl hyprpaper wallpaper ",$chosen"

    # Change hyprlock background automatically
    # sed -i "s|^ *path = .*|    path = $chosen|" "$HYPRLOCK_CONF"

    hyprctl reload
fi
