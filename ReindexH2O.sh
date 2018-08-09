#!/bin/bash

echo "Initializing..."

if [ ! -f h2o.conf ]; then
	echo "*** This isn't the H2O data folder"
	exit
fi

if [ $(ps -ef|grep h2od|grep -v grep|wc -l) -ne 0 ]; then
	echo "*** h2od is running, please stop with 'h2o-cli stop'"
 	exit
fi

echo "Download Bootstrap..."
rm -f H2O_BOOTSTRAP.tgz

curl https://raw.githubusercontent.com/ZioFabry/H2O_BOOTSTRAP/master/H2O_BOOTSTRAP.tgz --output H2O_BOOTSTRAP.tgz

if [ $? -ne 0 ]; then
	echo "*** error download bootstrap file"
	exit
fi

echo "Removing old files..."
rm -f banlist.dat fee_estimates.dat governance.dat mncache.dat mnpayments.dat netfulfilled.dat peers.dat
rm -r -f chainstate
rm -r -f blocks
rm -r -f database
rm debug.log*

echo "Installing Bootstrap..."
tar zxvvf H2O_BOOTSTRAP.tgz
rm -f H2O_BOOTSTRAP.tgz

BAK_FILE="h2o.conf.$(date +%Y%m%d%H%M%S).bak"

echo "Backup h2o.conf file to $BAK_FILE..."
mv h2o.conf $BAK_FILE

echo "Generating new h2o.conf file..."
cat $BAK_FILE|grep -v addnode >h2o.conf

echo " "
echo " "
echo ">>> Process Complete, now you can restart the daemon using the command 'h2od' <<<"
echo " "
