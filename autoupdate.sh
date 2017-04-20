#!/bin/bash

LOGFILE=$(date '+%Y-%m-%d_%H-%M-%S')
mkdir -p ./autoupdate/$LOGFILE
cd ./autoupdate/$LOGFILE

echo -e "[INFO] aptitude: starting indexing syncronization..."
sudo apt update 2>&1 | tee update.txt
if [ $? -ne 0 ]; then
	echo -e "[ERRO] aptitude: indexing syncronization failure"
	exit $?
fi
echo -e "[INFO] aptitude: indexing syncronization done"

echo -e "[INFO] aptitude: starting installation of newest versions of packages..."
sudo apt -y upgrade 2>&1 | tee upgrade.txt
if [ $? -ne 0 ]; then
	echo -e "[ERRO] aptitude: installation of newest versions of packages failure"
	exit $?
fi
sudo apt -y dist-upgrade 2>&1 | tee dist-upgrade.txt
if [ $? -ne 0 ]; then
	echo -e "[ERRO] aptitude: installation of newest versions of packages failure"
	exit $?
fi
echo -e "[INFO] aptitude: installation of newest versions of packages done"

echo -e "[INFO] aptitude: starting cache cleaning..."
sudo apt autoclean 2>&1 | tee autoclean.txt
if [ $? -ne 0 ]; then
	echo -e "[ERRO] aptitude: cache cleaning failure"
	exit $?
fi
echo -e "[INFO] aptitude: cache cleaning done"

exit 0

