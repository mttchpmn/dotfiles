#exec startxcfe4
[ -f ~/.Xresources ] && xrdb -merge -I $HOME ~/.Xresources
exec i3