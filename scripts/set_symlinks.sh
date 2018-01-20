#!/usr/bin/env bash
set -e
cd ${HOME}

makeDirectories () {
  mkdir -p 'code/me'
  mkdir -p 'bin'
}

dotFileSymLinker () {
  dotFileName=${1}
  if [ -z "${2}" ]; then
        dotFileSource="${dotFileName}"
  else
        dotFileSource="${2}"
  fi
  ln -sf "dotfiles/${dotFileSource}" "${dotFileName}"
}

#Home bin Setup
ln -sf /usr/local/bin/pip2 bin/pip
ln -sf /usr/local/bin/python2 bin/python
ln -sf ${HOME}/dotfiles/scripts/make_virtual_environment.sh bin/mkvirt
ln -sf ${HOME}/dotfiles/scripts/restart_mac_bluethooth.sh bin/rbt
ln -sf ${HOME}/dotfiles/scripts/team_contact_details.sh bin/team

linkHomeDirDotFiles () {
  dotFileSymLinker .gitconfig
  dotFileSymLinker .gitignore_global
  dotFileSymLinker .vimrc
  dotFileSymLinker .ideavimrc .vimrc
  dotFileSymLinker .zshrc
}

#Map Google Drive folders
ln -sf Google\ Drive/sound_clips sound_clips

setDefaultShell () {
  brew_zsh_path="/usr/local/bin/zsh"
  mac_os_current_shell="$(dscl . -read /Users/$USER UserShell | cut -d ' ' -f2-)"

  if ! grep -q "${brew_zsh_path}" /etc/shells; then
    echo "${brew_zsh_path}" | sudo tee -a /etc/shells > /dev/null
  fi

  if [ ${brew_zsh_path} != ${mac_os_current_shell} ]; then
    chsh -s "${brew_zsh_path}"
  fi
}

makeDirectories
linkHomeDirDotFiles
setDefaultShell
