#!/usr/bin/env bash
set -eu
contents="if [ -e "../.envrc" ]; then
  source_env ..
fi
source pipenvenv
git fetch --all --prune || true
echo \"Origin Default: \$(git symbolic-ref refs/remotes/origin/HEAD  --short | cut -d/ -f2-)\"
pyshow"

echo "${contents}" > .envrc
direnv allow
