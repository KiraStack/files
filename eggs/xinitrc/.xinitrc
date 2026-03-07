# Source /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set theme
xrandr
xrdb -merge ~/.Xresources >/dev/null 2>&1 || true
xsetroot -cursor_name left_ptr # fix x-shaped cursor

# Environment
export HISTCONTROL=ignoredups:erasedups
export XCURSOR_SIZE=32
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=bspwm

# Launch WM
exec bspwm
