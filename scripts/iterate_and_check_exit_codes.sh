#!/usr/bin/env bash
set -eu

ITERATIONS=10
DELAY_IN_SECONDS=0
while getopts "i:d:" flag; do
  case "$flag" in
      i) ITERATIONS=$OPTARG;;
      d) DELAY_IN_SECONDS=$OPTARG;;
  esac
  shift $((OPTIND-1))
done
if [ -z ${1+x} ]; then
  echo "No executable file provided as argument"
  exit 1
fi

itFailed() {
  logIt "fail"
}

itPassed() {
  logIt "pass"
}

logIt() {
  echo "$(date +%Y-%m-%dT%H:%M:%S%z) - ${1}"
}

for i in $(seq 1 ${ITERATIONS}); do
  ./run_tests.sh  > /dev/null 2>&1  && itPassed || itFailed
  sleep ${DELAY_IN_SECONDS}
done
