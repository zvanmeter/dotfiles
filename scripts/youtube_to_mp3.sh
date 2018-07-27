#!/usr/bin/env bash
set -eu

YOUTUBE_URL="${1}"
OUT_DIR="${HOME}/sound_clips/raw/"
mkdir -p "${OUT_DIR}"

downloadedFilePath="$(
  youtube-dl \
  --format bestaudio \
  --extract-audio \
  --audio-format mp3 \
  --restrict-filenames \
  --output '%(title)s.%(ext)s' \
  ${YOUTUBE_URL} \
  | grep -i 'destination.*mp3' \
  | cut -d':' -f2- \
  | tr -d ' '
)"

downloadedFileName="$(basename ${downloadedFilePath})"
outFile="$(
  echo ${downloadedFileName} \
  | tr '[:upper:]' '[:lower:]' \
  | tr '-' '_' \
  | tr -s _
)"
outFilePath="${OUT_DIR}${outFile}"
mv "${downloadedFilePath}" "${outFilePath}"
echo "Downloaded ${outFilePath}"
