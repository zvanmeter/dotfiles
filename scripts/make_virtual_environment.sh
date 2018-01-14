#!/usr/bin/env bash
set -e

virtType="${1}"
virtVersion="${2}"
envrc=''

function installNode() {
  pip install nodeenv
  nodeEnvVersion=''

  if [ -n "${virtVersion}" ]; then
    validVersion="$(nodeenv --list 2>&1 | tr '\t' '\n' | grep ^${virtVersion} | tail -1)"
    if [ -z "${validVersion}" ]; then
      echo "Unable to find node version for ${virtVersion}"
      rm -rf venv
      exit 1
    fi
    nodeEnvVersion="--node=${validVersion}"
  fi

  nodeenv -p "${nodeEnvVersion}"
  envrc+='npm config list\n'
}

function installPython() {
  pythonEnvrc=''
  pythonEnvrc+='pythonVersion="$(python --version 2>&1 | tr -d "\\n")"\n'
  pythonEnvrc+='pythonLocation="$(which python)"\n'
  pythonEnvrc+='echo "${pythonVersion} @ ${pythonLocation}"\n'

  envrc+="$pythonEnvrc"
}

function setupDirEnv(){
  defaultEnvrc=''
  defaultEnvrc+='if [ -e "../.envrc" ]; then\n'
  defaultEnvrc+='  source_env ..\n'
  defaultEnvrc+='fi\n'
  defaultEnvrc+='source venv/bin/activate\n'

  envrc="${defaultEnvrc}${envrc}"
  if hash direnv 2>/dev/null; then
    deactivate
    if [ ! -f ".envrc" ]; then
      echo -e "${envrc}" > .envrc
    fi
    direnv allow
  fi
}

rm -rf venv
virtualenv venv
source venv/bin/activate

if [ -z "${virtType}" ]; then
  installPython
elif [ "python" == "${virtType}" ]; then
  installPython
elif [ "node" == "${virtType}" ]; then
  installNode
fi

setupDirEnv
