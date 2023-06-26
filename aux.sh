check_and_install_command() {
    local command_name="$1"
    local formula_name="${2:-$command_name}"
    
    # Check if the command exists
    if ! command -v "$command_name" &> /dev/null; then
      echo "$command_name is not installed. Installing using Homebrew..."
      if ! brew install "$formula_name" > /dev/null; then
        echo "Failed to install $formula_name. Exiting."
        exit 1
      fi
    else
        echo "$command_name is already installed."
    fi
}
