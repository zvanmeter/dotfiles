#!/usr/bin/env bash
cd ${HOME}
mkdir -p bin
ln -sf .vimrc .ideavimrc
ln -sf /usr/local/bin/pip2 bin/pip
ln -sf /usr/local/bin/python2 bin/python
ln -sf dotfiles/scripts/make_virtual_environment.sh bin/mkvirt
ln -sf dotfiles/scripts/restart_mac_bluethooth.sh bin/rbt
ln -sf dotfiles/scripts/team_contact_details.sh bin/team

ln -sf dotfiles/.gitconfig .gitconfig
ln -sf dotfiles/.gitignore .gitignore_global
ln -sf dotfiles/.gitignore_global .gitignore_global
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.zshrc .zshrc

ln -sf Google\ Drive/sound_clips sound_clips

brew_zsh_path="/usr/local/bin/zsh"

if ! grep -q "${brew_zsh_path}" /etc/shells; then
  echo "${brew_zsh_path}" | sudo tee -a /etc/shells > /dev/null
fi

mac_os_current_shell="$(dscl . -read /Users/$USER UserShell | cut -d ' ' -f2-)"
if [ ${brew_zsh_path} != ${mac_os_current_shell} ]; then
  chsh -s "${brew_zsh_path}"
fi
