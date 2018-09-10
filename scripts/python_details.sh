#!/usr/bin/env bash
set -eu

pythonVersion="$(python --version 2>&1 | tr -d "\n")"
pythonLocation="$(which python)"
pythonAbsolute="$(realpath "${pythonLocation}")"
if [ "${pythonLocation}" != "${pythonAbsolute}" ]; then
  echo "Resolved Python: ${pythonAbsolute}"
fi
echo "${pythonVersion} via ${pythonLocation}"
