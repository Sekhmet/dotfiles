xsetroot -cursor_name left_ptr
setxkbmap pl

xrdb -merge ~/.Xresources

picom &
polybar &
dunst &
./.fehbg &
sxhkd &
exec bspwm


