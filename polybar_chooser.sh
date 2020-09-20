THEME_NUMBER="$1"

# change to home dir
cd $HOME

# clone this repo
git clone https://github.com/adi1090x/polybar-themes

# go to polybar-THEME_NUMBER dir
cd polybar-themes/polybar-"$THEME_NUMBER"

# copy fonts to local fonts dir (i'll put the fonts in all dirs)
cp -r fonts/* ~/.local/share/fonts

# reload font cache
fc-cache -v

# delete current font config (to be able to display bitmap fonts)
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf

# copy everything from polybar-THEME_NUMBER to polybar config dir (backup your config first if you have)
cp -r * ~/.config/polybar
