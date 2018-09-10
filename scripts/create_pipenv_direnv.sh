#!/usr/bin/env bash
set -eu
contents="if [ -e "../.envrc" ]; then
  source_env ..
fi
source pipenvenv
git fetch --all --prune || true
pyshow"

echo "${contents}" > .envrc
direnv allow
