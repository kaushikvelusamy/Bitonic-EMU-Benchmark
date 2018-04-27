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
    echo "usage: runTests [--mode=SIM or HW] [--datasetDir=DATASETDIR] [--outputDir=OUTPUTDIR]"
    echo "Dataset dir is required, output dir is optional (defaults to PWD), mode is optional (defaults to HW)"
}

DATADIR=""
OUTDIR="$PWD"
MODE="HW"
# parse arguments
for i in "${@}"; do
    case "${i}" in
        # help
        -h|--help)
        show_help
        exit 0
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
    printf "${RED}ERROR: Dataset directory must be specified and contain small/, medium/, large/\n${NOCOLOR}"
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

OUTDIR+="/output_data"

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
mkdir -p ${OUTDIR}/small
# We only run on medium and large if we are on the hardware
if [[ "${MODE}" == "HW" ]];
then
    mkdir -p ${OUTDIR}/medium
    mkdir -p ${OUTDIR}/large
fi

#######################################################################################
##
## 2.) Run tests for bitonic (CPU) iterative on small data sets
##
#######################################################################################
echo ""
TIME_START=`date +%s`
currDate=`date`
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${CYAN}+ Running tests for bitonic sort (EMU ${MODE} iterative) on small data sets\n${NOCOLOR}"
printf "${RED} + START TIME: ${currDate}\n${NOCOLOR}"

# Gets all data set files in small/ in ascending order of file size
dataFiles=( $(ls -lSR ${DATADIR}/small/* | sort -k 5 -n | sed 's/ \+/\t/g' | cut -f 9) )
for dataFile in "${dataFiles[@]}"
do
    # Silly way to parse out the number of elements from the file name
    # i.e.,: dataFile = dataset1024.dat, so we want to get numElements=1024
    # We use this to name our output file
    delimiter=dataset
    s=$dataFile$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    temp=${dataFileName[1]}
    delimiter=.dat
    s=$temp$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    numElements=${dataFileName[0]}
    mkdir -p ${OUTDIR}/small/${numElements}

    if [[ "${MODE}" == "SIM" ]];
    then
        mkdir -p ${OUTDIR}/small/${numElements}/cdc
        mkdir -p ${OUTDIR}/small/${numElements}/vsf    
    else
        EXE="emu_handler_and_loader 0 0 bitonic_EMU_iterative.mwx --"
    fi

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        if [[ "${MODE}" == "SIM" ]];
        then
            EXE="emusim.x --short_trace --gcs_per_nodelet 1 -o ${numElements}_trial${TRIAL} bitonic_EMU_iterative.mwx"
        fi
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ${EXE} ${dataFile} &> ${OUTDIR}/small/${numElements}/${numElements}_trial${TRIAL}.out
        if [[ "${MODE}" == "SIM" ]];
        then
            mv ${numElements}_trial${TRIAL}.vsf ${OUTDIR}/small/${numElements}/vsf
            mv ${numElements}_trial${TRIAL}.cdc ${OUTDIR}/small/${numElements}/cdc
        fi
    done
    printf "\n"
done

TIME_END=`date +%s`
TIME_TOTAL=$((TIME_END-TIME_START))
currDate=`date`
printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
printf "${RED}TOTAL TIME: ${TIME_TOTAL} seconds\n\n${NOCOLOR}"

# If we are running on the simulator, then don't do medium or large data sets
if [[ "${MODE}" == "SIM" ]];
then
    totalEnd=`date +%s`
    totalTime=$((totalEnd-totalStart))
    currDate=`date`
    echo ""
    printf "${YELLOW}######################################################################################\n${NOCOLOR}"
    printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
    printf "${RED}TOTAL TIME: ${totalTime} seconds\n${NOCOLOR}"
    echo ""
    exit -1
fi

#######################################################################################
##
## 2.) Run tests for bitonic (CPU) iterative on medium data sets
##
#######################################################################################
echo ""
TIME_START=`date +%s`
currDate=`date`
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${CYAN}+ Running tests for bitonic sort (CPU, iterative) on medium data sets\n${NOCOLOR}"
printf "${RED} + START TIME: ${currDate}\n${NOCOLOR}"

dataFiles=( $(ls -lSR ${DATADIR}/medium/* | sort -k 5 -n | sed 's/ \+/\t/g' | cut -f 9) )
for dataFile in "${dataFiles[@]}"
do
    delimiter=dataset
    s=$dataFile$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    temp=${dataFileName[1]}
    delimiter=.dat
    s=$temp$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    numElements=${dataFileName[0]}
    if [[ "${MODE}" == "HW" ]];
    then
        EXE="emu_handler_and_loader 0 0 bitonic_EMU_iterative.mwx --"
    fi

    mkdir -p ${OUTDIR}/medium/${numElements}

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ${EXE} ${dataFile} &> ${OUTDIR}/medium/${numElements}/${numElements}_trial${TRIAL}.out
    done
    printf "\n"
done

TIME_END=`date +%s`
TIME_TOTAL=$((TIME_END-TIME_START))
currDate=`date`
printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
printf "${RED}TOTAL TIME: ${TIME_TOTAL} seconds\n\n${NOCOLOR}"

#######################################################################################
##
## 2.) Run tests for bitonic (CPU) iterative on large data sets
##
#######################################################################################
echo ""
TIME_START=`date +%s`
currDate=`date`
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${CYAN}+ Running tests for bitonic sort (CPU, iterative) on large data sets\n${NOCOLOR}"
printf "${RED} + START TIME: ${currDate}\n${NOCOLOR}"

dataFiles=( $(ls -lSR ${DATADIR}/large/* | sort -k 5 -n | sed 's/ \+/\t/g' | cut -f 9) )
for dataFile in "${dataFiles[@]}"
do
    delimiter=dataset
    s=$dataFile$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    temp=${dataFileName[1]}
    delimiter=.dat
    s=$temp$delimiter
    dataFileName=()
    while [[ $s ]]; do
        dataFileName+=( "${s%%"$delimiter"*}" )
        s=${s#*"$delimiter"};
    done
    declare -a dataFileName
    numElements=${dataFileName[0]}
    if [[ "${MODE}" == "HW" ]];
    then
        EXE="emu_handler_and_loader 0 0 bitonic_EMU_iterative.mwx --"
    fi

    mkdir -p ${OUTDIR}/large/${numElements}

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ${EXE} ${dataFile} &> ${OUTDIR}/large/${numElements}/${numElements}_trial${TRIAL}.out
    done
    printf "\n"
done

TIME_END=`date +%s`
TIME_TOTAL=$((TIME_END-TIME_START))
currDate=`date`
printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
printf "${RED}TOTAL TIME: ${TIME_TOTAL} seconds\n\n${NOCOLOR}"

##########################################################################
totalEnd=`date +%s`
totalTime=$((totalEnd-totalStart))
currDate=`date`
echo ""
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${RED}END TIME:   ${currDate}\n${NOCOLOR}"
printf "${RED}TOTAL TIME: ${totalTime} seconds\n${NOCOLOR}"
echo ""
