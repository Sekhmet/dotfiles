xsetroot -cursor_name left_ptr

xrdb -merge ~/.Xresources

setxkbmap pl

picom &
polybar &
udiskie &
dunst &
./.fehbg &
sxhkd &
exec bspwm
