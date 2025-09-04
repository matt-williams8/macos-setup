#!/bin/zsh

# Install homebrew and add it to the path of the current shell for installing git without ansible
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install git and clone the rest of this repo to get the ansible playbooks
brew install git
git clone https://github.com/matt-williams8/macos-setup.git $HOME/src/macos-setup
cd $HOME/src/macos-setup

# Ideally mise would be managed by ansible as well, but we will use it to install other tools that are needed to install ansible itself.
# We will only temporarily activate it add it to the path of the current shell, all permanent configuration will be done in the ansible playbook
/bin/bash -c "$(curl https://mise.run | sh)"
export PATH=$HOME/.local/bin:$PATH

# Install python 3 but only configured in a local toml (that won't be committed) to avoid conflicts with global python settings
mise use --path mise.local.toml python@3

# Seemed to need to activate after installing python, but unclear why
eval "$(mise activate bash)"

python -m pip install --user ansible
ansible-playbook $HOME/src/macos-setup/macos.yml