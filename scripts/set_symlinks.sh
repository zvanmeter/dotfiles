#!/usr/bin/env bash
set -euo
cd "${HOME}"

# Restore shell history
# Restore ssh
# Install Homebrew
# Clone this repo to code/me/dotfiles
# Run this script

BREW_BIN="$(brew --prefix)/bin"

makeDirectories () {
  mkdir -p 'code/me'
  mkdir -p 'bin'
  symLinker 'Google Drive/sound_clips'
  symLinker 'code/me/dotfiles'
}

symLinker () {
  source="${1}"
  target="${2}"

  if [ -z "${target}" ]; then
        target="$(basename "${source}")"
  fi

  ln -sfn "${source}" "${target}"
}

dotFileSymLinker () {
  dotFileName=${1}
  dotFileLinkName=${2}
  symLinker "dotfiles/${dotFileName}" "${dotFileLinkName}"
}

scriptSymLinker () {
  binName=${1}
  scriptName=${2}
  symLinker "${HOME}/dotfiles/scripts/${scriptName}" "bin/${binName}"
}

aliasSymLinker () {
  aliasName=${1}
  realLocation=${2}
  symLinker "${realLocation}" "bin/${aliasName}"
}

setBinLinks () {
  scriptSymLinker mkvirt make_virtual_environment.sh
  scriptSymLinker rbt restart_mac_bluethooth.sh
  scriptSymLinker team team_contact_details.sh
}

linkHomeDirDotFiles () {
  dotFileSymLinker .gitconfig
  dotFileSymLinker .gitignore_global
  dotFileSymLinker .vim
  dotFileSymLinker .vimrc
  dotFileSymLinker .vimrc .ideavimrc
  dotFileSymLinker .zshrc
}

setDefaultShell () {
  brew_zsh_path="${BREW_BIN}/zsh"

  if ! grep -q "${brew_zsh_path}" /etc/shells; then
    echo "Adding ${brew_zsh_path} to /etc/shells"
    echo "${brew_zsh_path}" | sudo tee -a /etc/shells > /dev/null
  fi

  echo "Setting default shell to ${brew_zsh_path}"
  chsh -s "${brew_zsh_path}"
}

brewInstaller () {
  toInstall="${1}"
  brewInstalled="$(brew list -1)"
  if ! echo "${brewInstalled}" | grep -q "^${toInstall}$" ; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "${toInstall}"
  fi
}

installCoreBrew () {
  brewInstaller ack
  brewInstaller coreutils
  brewInstaller direnv
  brewInstaller eza
  brewInstaller fd
  brewInstaller fzf
  brewInstaller git
  brewInstaller gnu-sed
  brewInstaller grep
  brewInstaller jq
  brewInstaller pipenv
  brewInstaller vim
  brewInstaller z
  brewInstaller zsh
  brewInstaller zsh-autosuggestions
  brewInstaller zsh-syntax-highlighting
}

installFonts () {
  HOMEBREW_NO_AUTO_UPDATE=1 brew tap caskroom/fonts
  HOMEBREW_NO_AUTO_UPDATE=1 brew cask install font-source-code-pro font-fira-code font-iosevka
}

generateGitHubKey () {
  gitHubKeyFile="${HOME}/.ssh/github"
  if [ ! -f "${gitHubKeyFile}" ]; then
    ssh-keygen -t rsa -b 4096 -f "${gitHubKeyFile}" -N ''
    echo "Host github.com" >> .ssh/config
    echo "  IdentityFile ${gitHubKeyFile}" >> .ssh/config
  fi
}

addTouchBarToSudo () {
  if [ -d "/System/Library/PreferencePanes/TouchID.prefPane" ] ; then
    sudo gsed -i '/pam_tid.so/d' /etc/pam.d/sudo
    sudo gsed -i '2s/^/auth       sufficient     pam_tid.so\n/' /etc/pam.d/sudo
  fi
}

installCoreBrew
installFonts
makeDirectories
linkHomeDirDotFiles
setDefaultShell
setBinLinks
generateGitHubKey
addTouchBarToSudo
