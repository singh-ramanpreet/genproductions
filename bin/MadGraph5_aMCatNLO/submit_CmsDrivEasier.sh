#!/bin/bash

prepid=${1}
jobflavour=${2:-"workday"}
args=${3:-"source CmsDrivEasier.sh ${prepid} 1000 1"}

mkdir -p ${prepid}

echo $args &> ${prepid}/${prepid}_script.sh

condor_submit \
    executable=/bin/bash \
    output=${prepid}/${prepid}.out \
    error=${prepid}/${prepid}.err \
    log=${prepid}/${prepid}.log \
    stream_error=True \
    stream_output=True \
    transfer_input_files=CmsDrivEasier.sh,${prepid}/${prepid}_script.sh \
    transfer_output_files="\"\"" \
    -append "+JobFlavour=\"${jobflavour}\"" \
    -append "arguments=${prepid}_script.sh" \
    -append "queue 1" \
    /dev/null
