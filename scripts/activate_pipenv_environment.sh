if pipenv --venv > /dev/null 2>&1; then
  pipenvVirt="$(pipenv --venv)/bin/activate"
  source "${pipenvVirt}"
  export PIPENV_ACTIVE=1
fi
