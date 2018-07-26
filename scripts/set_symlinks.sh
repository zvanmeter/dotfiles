#!/usr/bin/env bash
set -e
cd ${HOME}

# Restore shell history
# Restore ssh
# Install Homebrew
# Clone this repo to code/me/dotfiles
# Run this script

BREW_INSTALLED="$(brew list -1)"
BREW_INSTALL_DIR='/usr/local/bin'

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
  symLinker ${HOME}/dotfiles/scripts/${scriptName} bin/${binName}
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

setBinAliases () {
  aliasSymLinker pip "${BREW_INSTALL_DIR}/pip2"
  aliasSymLinker python "${BREW_INSTALL_DIR}/python2"
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
  brew_zsh_path="${BREW_INSTALL_DIR}/zsh"
  mac_os_current_shell="$(dscl . -read /Users/$USER UserShell | cut -d ' ' -f2-)"

  if ! grep -q "${brew_zsh_path}" /etc/shells; then
    echo "${brew_zsh_path}" | sudo tee -a /etc/shells > /dev/null
  fi

  if [ ${brew_zsh_path} != ${mac_os_current_shell} ]; then
    chsh -s "${brew_zsh_path}"
  fi
}

brewInstaller () {
  toInstall="${1}"

  if ! echo "${BREW_INSTALLED}" | grep -q "^${toInstall}$" ; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "${toInstall}"
    BREW_INSTALLED="$(brew list -1)"
  fi
}

installCoreBrew () {
  brewInstaller ack
  brewInstaller coreutils
  brewInstaller direnv
  brewInstaller exa
  brewInstaller fd
  brewInstaller git
  brewInstaller gnu-sed
  brewInstaller grep
  brewInstaller jq
  brewInstaller pipenv
  brewInstaller python
  brewInstaller python@2
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
  fi
}

installCoreBrew
installFonts
makeDirectories
linkHomeDirDotFiles
setDefaultShell
setBinLinks
setBinAliases
generateGitHubKeuy
