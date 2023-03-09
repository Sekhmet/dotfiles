xsetroot -cursor_name left_ptr
setxkbmap pl

xrdb -merge ~/.Xresources

picom &
polybar &
./.fehbg &
sxhkd &
exec bspwm


