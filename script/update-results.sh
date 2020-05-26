#!/usr/bin/env bash

set -eo pipefail

script_dir="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
root_dir="$(cd "${script_dir}/.." && pwd)"
autoeq_dir="${root_dir}/AutoEq"
ath_m50_results="${root_dir}/Audio-Technica-ATH-M50"

pushd "${script_dir}/.." || exit
  git submodule update --init --recursive
popd || exit

source "${root_dir}/venv/bin/activate"
pip install -r "${autoeq_dir}/requirements.txt"

for boost in 4 6 9; do
  python "${autoeq_dir}/autoeq.py" \
    --input_dir="${autoeq_dir}/measurements/headphonecom/data/onear/Audio-Technica ATH-M50" \
    --output_dir="${ath_m50_results}/bass-boost-${boost}" \
    --compensation="${autoeq_dir}/measurements/headphonecom/resources/headphonecom_harman_over-ear_2018_wo_bass.csv" \
    --equalize \
    --bass_boost=${boost} \
    --parametric_eq \
    --ten_band_eq \
    --max_filters 10
done
