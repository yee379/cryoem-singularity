#!/bin/sh

sudo /opt/singularity/bin/singularity shell --writable \
  -B /usr/lib64/libcuda.so.$(/sbin/modinfo -F version nvidia):/.singularity.d/libs/libcuda.so.1 \
  -B /usr/lib64/libnvidia-fatbinaryloader.so.$(/sbin/modinfo -F version nvidia):/.singularity.d/libs/libnvidia-fatbinaryloader.so.$(/sbin/modinfo -F version nvidia) \
  -B /gpfs:/gpfs \
    cryoem/
