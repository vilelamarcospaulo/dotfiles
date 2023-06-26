source $PWD/aux.sh

check_and_install_command "nvim" "neovim"

packer_dir=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d $packer_dir ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
  echo "Packer installed"
else
  echo "Packer already installed"
fi

neovim_dir=~/.neovim
if [ ! -d $neovim_dir ]; then
  git clone git@github.com:vilelamarcospaulo/.neovim.git ~/.neovim
else
  echo "$neovim_dir already exists, please check it is in the right branch"
fi

ln -s ~/.neovim ~/.config/nvim

messages=("Remember to run :PackeSync inside nvim" "Remember to run :checkhealth inside nvim")
warning "${messages[@]}"

