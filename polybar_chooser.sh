THEME_NUMBER="$1"

# change to home dir
cd $HOME

# clone this repo
git clone https://github.com/adi1090x/polybar-themes

# go to polybar-THEME_NUMBER dir
cd polybar-themes/
echo 1 | ./setup.sh

# reload font cache
fc-cache -v
