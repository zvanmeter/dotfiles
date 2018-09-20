#!/usr/bin/env bash
set -eu
contents="if [ -e "../.envrc" ]; then
  source_env ..
fi
export PYENV_ROOT="$HOME/.pyenv"
source pipenvenv
git fetch --all --prune || true
echo \"Origin Default: \$(git symbolic-ref refs/remotes/origin/HEAD  --short | cut -d/ -f2-)\"
pyshow"

echo "${contents}" > .envrc
direnv allow
