pipenvVirt="$(pipenv --venv)/bin/activate"
if [ -e "${pipenvVirt}" ]; then
  source "${pipenvVirt}"
  export PIPENV_ACTIVE=1
fi
