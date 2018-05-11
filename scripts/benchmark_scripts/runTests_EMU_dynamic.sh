#!/bin/bash

# Defines some color codes to use
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NOCOLOR='\033[0m'


show_help() 
{
    echo "usage: runTests [--exe=PATH TO EXE] [--mode=SIM or HW] [--datasetDir=DATASETDIR] [--outputDir=OUTPUTDIR]"
    echo "Dataset dir and exe is required, output dir is optional (defaults to PWD), mode is optional (defaults to HW)"
}

DATADIR=""
OUTDIR="$PWD"
MODE="HW"
EXEPATH=""
# parse arguments
for i in "${@}"; do
    case "${i}" in
        # help
        -h|--help)
        show_help
        exit 0
        ;;
        --exe=*)
        EXEPATH=${i#*=} 
        ;;
        --datasetDir=*)
        DATADIR=${i#*=}
        ;;
        --outputDir=*)
        OUTDIR=${i#*=}
        ;;
        --mode=*)
        MODE=${i#*=}
        ;;
        # bad argument
        *)
        die "Unknown option '${i}'"
        ;;
    esac
done

# Make sure data set dir was given
if [[ -z "${DATADIR}" ]]
then
    printf "${RED}ERROR: Dataset directory must be specified\n${NOCOLOR}"
    show_help
    exit -1
fi

# Make sure exe path was given
if [[ -z "${EXEPATH}" ]]
then
    printf "${RED}ERROR: Executable path directory must be specified.\n${NOCOLOR}"
    show_help
    exit -1
fi

# Store MODE in all uppercase
MODE=${MODE^^}

# Make sure we have a valid mode (SIM or HW)
if [[ "${MODE}" != "SIM" && "${MODE}" != "HW" ]];
then
    printf "${RED}ERROR: Mode specified with --mode must be HW or SIM (case insensitive)\n${NOCOLOR}"
    show_help
    exit -1
fi

today=`date +%Y-%m-%d.%H:%M:%S`
OUTDIR+="/output_data_DYNAMIC_${today}"

######################################################################################
#
# 1.) Create output directory
#
######################################################################################
echo ""
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
totalStart=`date +%s`
currDate=`date`
printf "${RED}+ START TIME: ${currDate}\n\n${NOCOLOR}"

printf "${CYAN}+ Creating output directory: $OUTDIR\n${NOCOLOR}"

mkdir -p ${OUTDIR}

#######################################################################################
##
## 2.) Run tests for bitonic dynamic sort
##
#######################################################################################
echo ""
currDate=`date`
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${CYAN}+ Running tests for ${EXEPATH} (EMU ${MODE})\n${NOCOLOR}"
printf "${RED} + START TIME: ${currDate}\n${NOCOLOR}"

# Gets all data set files in ascending order of file size
dataFiles=( $(ls -lSR ${DATADIR}/* | sort -k 5 -n | sed 's/ \+/\t/g' | cut -f 9) )
for dataFile in "${dataFiles[@]}"
do
    # Helper function for parsing file names
    # Silly way to parse out the number of elements from the file name
    # i.e.,: dataFile = dataset1024.dat, so we want to get numElements=1024
    #  We use this to name our output file
    delimiter=dataset
    s=$dataFile$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    temp=${dataFileName[-1]}
    delimiter=.dat
    s=$temp$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    numElements=${dataFileName[0]}

    baseDir="${OUTDIR}/${numElements}_elements"
    baseFile="${numElements}elements"

    mkdir -p $baseDir

    OPTS="-b -f $dataFile"

    if [[ "${MODE}" == "SIM" ]];
    then
        mkdir -p ${baseDir}/cdc
        mkdir -p ${baseDir}/vsf    
        mkdir -p ${baseDir}/tqd
        EXE="emusim.x --core_clk_mhz 150 --capture_timing_queues --gcs_per_nodelet 1 -o ${baseFile} ${EXEPATH} --"
    else
        EXE="time emu_handler_and_loader 0 0 ${EXEPATH} --"
    fi
            
    now=`date +%Y-%m-%d.%H:%M:%S`
    printf "[${now}] Running on dataset: ${dataFile}\n"
    (${EXE} ${OPTS}) > ${baseDir}/${baseFile}.out 2>&1
    if [[ "${MODE}" == "SIM" ]];
    then
        mv  ${baseFile}.vsf ${baseDir}/vsf 2>/dev/null
        mv  ${baseFile}.cdc ${baseDir}/cdc 2>/dev/null
        mv  ${baseFile}.tqd ${baseDir}/tqd 2>/dev/null
    fi
    printf "\n"
done 

##########################################################################
totalEnd=`date +%s`
totalTime=$((totalEnd-totalStart))
currDate=`date`
echo ""
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
printf "${RED}TOTAL TIME: ${totalTime} seconds\n${NOCOLOR}"
echo ""
