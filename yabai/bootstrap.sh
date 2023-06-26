source $PWD/aux.sh

# Install
check_and_install_command "yabai" "koekeishiya/formulae/yabai"
cpath=~/.config/yabai

# Symlink the yabai config file to the home directory
if [ ! -d $cpath ]; then
    mkdir -p $cpath
    echo "Created $cpath directory."
fi

if [ ! -f $cpath/yabairc ]; then
    ln -s $PWD/yabai/yabairc $cpath/yabairc
else
    echo "Yabai config file already exists. Skipping symlink."
fi
