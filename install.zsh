#!/bin/zsh

# Install homebrew and add it to the path of the current shell for installing git without ansible
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install git and clone the rest of this repo to get the ansible playbooks
brew install git
git clone https://github.com/matt-williams8/macos-setup.git $HOME/src/macos-setup

# Install pyenv and temporarily add it to the path of the current shell so we can better manage python and pip versions
brew install pyenv
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"

# Install a more up-to-date version of python than is shipped with macOS
PYTHON_VERSION=3.10.1
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# Install ansible and temporarily add pip packages to path so we can invoke it to run the playbooks
python -m pip install --user ansible
export PATH=$HOME/.local/bin:$PATH

# Kick things off
ansible-galaxy install -r requirements.yml
ansible-playbook --skip-tags sdkman_privelege $HOME/src/macos-setup/site.yml
