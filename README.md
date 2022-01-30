# macOS setup

An ansible based "backup" of my preferred macOS dev machine setup.

## Getting started

 1. "Prime" `pip3`
    * When getting started with macOS 12.X (Monterey) I found that just testing to see if `pip3` was installed triggered the xcode CLI tools install
    * `pip3`, `pip3 --version`, etc
 1. Download and run [`install.zsh`](install.zsh)

 ## Applying changes

 Once the [`install.zsh`](install.zsh) script has been run once to do the initial setup/core package install, any future changes made to the playbook can be applied via `ansible-playbook $HOME/src/macos-setup/site.yml`.
