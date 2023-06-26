#!/bin/bash

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
if ! command -v git &> /dev/null; then
    # Install Git using Homebrew
    brew install git
else
    echo "Git is already installed."
fi

