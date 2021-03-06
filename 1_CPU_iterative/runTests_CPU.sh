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
    echo "usage: runTests [--datasetDir=DATASETDIR] [--outputDir=OUTPUTDIR]"
    echo "Dataset dir is required, output dir is optional (defaults to PWD)"
}

DATADIR=""
OUTDIR="$PWD"
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

today=`date +%Y-%m-%d.%H:%M:%S`
OUTDIR+="/output_data_${today}"

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
mkdir -p ${OUTDIR}/medium
mkdir -p ${OUTDIR}/large

#######################################################################################
##
## 2.) Run tests for bitonic (CPU) iterative on small data sets
##
#######################################################################################
echo ""
TIME_START=`date +%s`
currDate=`date`
printf "${YELLOW}######################################################################################\n${NOCOLOR}"
printf "${CYAN}+ Running tests for bitonic sort (CPU, iterative) on small data sets\n${NOCOLOR}"
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
    mkdir -p ${OUTDIR}/small/${numElements}

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ./bitonic_CPU_iterative ${dataFile} &> ${OUTDIR}/small/${numElements}/${numElements}_trial${TRIAL}.out
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

    mkdir -p ${OUTDIR}/medium/${numElements}

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ./bitonic_CPU_iterative ${dataFile} &> ${OUTDIR}/medium/${numElements}/${numElements}_trial${TRIAL}.out
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

    mkdir -p ${OUTDIR}/large/${numElements}

    # Run 5 trials for each data set
    for TRIAL in 1 2 3 4 5
    do
        printf "[TRIAL=${TRIAL}] Running on dataset: ${dataFile}\n"
        ./bitonic_CPU_iterative ${dataFile} &> ${OUTDIR}/large/${numElements}/${numElements}_trial${TRIAL}.out
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
