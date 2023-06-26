# Install
if ! command -v yabai &> /dev/null; then
    brew install git
else
    echo "Yabai is already installed."
fi


# Symlink the yabai config file to the home directory
cpath=~/.config/yabai
if [ ! -d $cpath ]; then
    mkdir -p $cpath
    echo "Created $cpath directory."
fi

if [ ! -f $cpath/yabairc ]; then
    ln -s $PWD/yabai/yabairc $cpath/yabairc
else
    echo "Yabai config file already exists."n
fi
