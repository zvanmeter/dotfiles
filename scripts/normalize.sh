#!/usr/bin/env bash
set -eu

INPUT_FILE="${1}"
DEFAULT_TARGET_LOUDNESS_IN_DB="-14"
TARGET_LOUDNESS_IN_DB="${2:-${DEFAULT_TARGET_LOUDNESS_IN_DB}}"

OUT_DIR="${HOME}/sound_clips/normalized/"
OUT_FILE="$(basename ${INPUT_FILE})"
OUT_FILE_PATH="${OUT_DIR}${OUT_FILE}"

mkdir -p "${OUT_DIR}"
echo "Target Average Loundess is ${TARGET_LOUDNESS_IN_DB}"

function printVolumeStats () {
  fileName="${1}"
  echo "Volume Stats for ${INPUT_FILE}:"
  ffmpeg \
    -i "${fileName}" \
    -filter:a volumedetect \
    -f null \
    /dev/null 2>&1 \
  | grep dB \
  | cut -d ']' -f2
}

normalizationStatsJson="$(
  ffmpeg \
   -y \
   -i "${INPUT_FILE}" \
   -pass 1 \
   -filter:a loudnorm=print_format=json \
   -f null \
   /dev/null 2>&1 \
  | sed -n -e '/{/,$p'
 )"
integratedLoudness="$(echo ${normalizationStatsJson} | jq --raw-output .'input_i')"
loundessRange="$(echo ${normalizationStatsJson} | jq --raw-output .'input_lra')"
truePeak="$(echo ${normalizationStatsJson} | jq --raw-output .'input_tp')"
threshold="$(echo ${normalizationStatsJson} | jq --raw-output .'input_thresh')"

ffmpeg \
 -y \
 -i "${INPUT_FILE}" \
 -pass 2 \
 -filter:a loudnorm=linear=true:I=${TARGET_LOUDNESS_IN_DB}:LRA=6:measured_I=${integratedLoudness}:measured_LRA=${loundessRange}:measured_tp=${truePeak}:measured_thresh=${threshold} \
 "${OUT_FILE_PATH}"  2>&1| grep -i -e 'output' -e 'size' | tr -s ' '

printVolumeStats "${INPUT_FILE}"
printVolumeStats "${OUT_FILE_PATH}"
