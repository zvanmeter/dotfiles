export PYENV_ROOT="$HOME/.pyenv"
if pipenv --venv > /dev/null 2>&1; then
  export PIPENV_ACTIVE=1
  pipenvVirt="$(pipenv --venv)/bin/activate"
  source "${pipenvVirt}"
fi
