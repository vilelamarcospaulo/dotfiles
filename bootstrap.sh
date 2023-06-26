#!/bin/bash

source ./aux.sh

# First thing to run on a new machine
# Basic needed tools are installed here
# (e.g. Homebrew, Git)

# Installs Homebrew 
if ! command -v brew &> /dev/null; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install Git
check_and_install_command "git"

modules=$(ls -d "$PWD"/*/)
for module in $modules; do
    echo "\nProcessing module: $module"
    bash "$module"/bootstrap.sh
done
