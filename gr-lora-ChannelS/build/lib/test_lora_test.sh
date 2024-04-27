#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/ningning/gr-lora-master-nt/lib
export GR_CONF_CONTROLPORT_ON=False
export PATH=/home/ningning/gr-lora-master-nt/build/lib:$PATH
export LD_LIBRARY_PATH=/home/ningning/gr-lora-master-nt/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH
test-lora 
