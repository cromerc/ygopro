#!/bin/bash
if [ -d /lib64 ]; then
	LD_PRELOAD="libcurl.so.3" ./ygopro64
else
	LD_PRELOAD="libcurl.so.3" ./ygopro32
fi
