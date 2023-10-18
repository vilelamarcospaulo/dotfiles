source $PWD/aux.sh

check_and_install_command "nvim" "neovim"

neovim_dir=~/.neovim
if [ ! -d $neovim_dir ]; then
  git clone git@github.com:vilelamarcospaulo/.neovim.git ~/.neovim
else
  echo "$neovim_dir already exists, please check it is in the right branch"
fi

ln -s ~/.neovim ~/.config/nvim

