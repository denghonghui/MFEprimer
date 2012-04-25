#!/bin/bash

# Index database for MFEprimer-2.0
# Wubin Qu <quwubin@gmail.com>

MFEHOME=$(dirname $(which ${0}))

if [ $# == 2 ]
then
    fasta_file=$1
    k=$2
else
    echo Usage:  
    echo
    echo     $(basename $0) Fasta_file K_value
    echo
    echo Example:  
    echo
    echo     $(basename $0) Human.fasta 9
    echo
    exit
fi

echo "Begin indexing ..."

$MFEHOME/chilli/UniFastaFormat.py -i $fasta_file

echo "Step 1/3: UniFasta done."

$MFEHOME/bin/faToTwoBit $fasta_file.unifasta $fasta_file.2bit

echo "Step 2/3: faToTwoBit done."


echo "Step 3/3: Index begin ..."

$MFEHOME/chilli/mfe_index_db.py -f $fasta_file.unifasta -k $k

echo "Step 3/3: Index done"

rm $fasta_file.unifasta