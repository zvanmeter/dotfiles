#!/usr/bin/env bash

team_csv="${BASH_SOURCE%/*}/team.csv"
if [ $# -eq 0 ]; then
    cat "$team_csv" | sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t
    exit 0
fi
csvHeaders=$(head -1 $team_csv)
arrHeaders=(${csvHeaders//,/ })

columnArgs=""
for var in "$@"; do
    columnArgs+=' ,$'$var
done
columnArgs="$(echo $columnArgs | cut -c 2-)"

cat "$(echo $team_csv)" | sed "s/,,/, ,/g;s/,,/, ,/g" | column -s, -t | awk "{print $columnArgs}"
