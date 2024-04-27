#!/bin/sh
export VOLK_GENERIC=1
export GR_DONT_LOAD_PREFS=1
export srcdir=/home/ningning/gr-lora-master-nt/python
export GR_CONF_CONTROLPORT_ON=False
export PATH=/home/ningning/gr-lora-master-nt/build/python:$PATH
export LD_LIBRARY_PATH=/home/ningning/gr-lora-master-nt/build/lib:$LD_LIBRARY_PATH
export PYTHONPATH=/home/ningning/gr-lora-master-nt/build/swig:$PYTHONPATH
/usr/bin/python2 /home/ningning/gr-lora-master-nt/python/qa_encode.py 
