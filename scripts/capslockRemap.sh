#!/bin/sh
#Reference in ~/.config/autostart to remap keys on ubuntu launch

#Set a held down caps lock to be ctrl
setxkbmap -option 'caps:ctrl_modifier'

#Set a tapped caps lock to be Esc
command -v xcape >/dev/null 2>&1 || { echo >&2 "xcape not present, capslock will not be esc."; exit 1; }
xcape -e 'Caps_Lock=Escape'
