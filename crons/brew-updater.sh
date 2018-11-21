#!/usr/bin/env bash
set -eu

brewDir='/usr/local/bin'
export PATH="${brewDir}:${PATH}"
export HOMEBREW_NO_AUTO_UPDATE=1

brew update > /dev/null
brew upgrade --display-times
brew cleanup -s

