#!/usr/bin/env bash
cd ${HOME}

#Home bin Setup
mkdir -p bin
ln -sf /usr/local/bin/pip2 bin/pip
ln -sf /usr/local/bin/python2 bin/python
ln -sf ${HOME}/dotfiles/scripts/make_virtual_environment.sh bin/mkvirt
ln -sf ${HOME}/dotfiles/scripts/restart_mac_bluethooth.sh bin/rbt
ln -sf ${HOME}/dotfiles/scripts/team_contact_details.sh bin/team

#Set up home dir configs
ln -sf dotfiles/.gitconfig .gitconfig
ln -sf dotfiles/.gitignore .gitignore_global
ln -sf dotfiles/.gitignore_global .gitignore_global
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.vimrc .ideavimrc
ln -sf dotfiles/.zshrc .zshrc

#Map Google Drive folders
ln -sf Google\ Drive/sound_clips sound_clips

#Shell Changes
brew_zsh_path="/usr/local/bin/zsh"
if ! grep -q "${brew_zsh_path}" /etc/shells; then
  echo "${brew_zsh_path}" | sudo tee -a /etc/shells > /dev/null
fi

mac_os_current_shell="$(dscl . -read /Users/$USER UserShell | cut -d ' ' -f2-)"
if [ ${brew_zsh_path} != ${mac_os_current_shell} ]; then
  chsh -s "${brew_zsh_path}"
fi
