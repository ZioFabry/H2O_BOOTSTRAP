#!/bin/bash

if [ ! -f h2o.conf ]; then
	echo "*** This isn't the H2O data folder"
	exit
fi

if [ $(ps -ef|grep h2od|grep -v grep|wc -l) -ne 0 ]; then
	echo "*** h2od is running, please stop with 'h2o-cli stop'"
	exit
fi


echo "done"
