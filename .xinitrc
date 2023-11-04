setxkbmap -option caps:escape
feh --bg-scale ~/.config/wallpaper.png
dwmblocks 2>&1 >/dev/null &
exec dwm
