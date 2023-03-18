#!/bin/sh

source ../modules/modules.summit.gnugpu

./configure \
--with-cc=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/spectrum-mpi-10.4.0.3-20210112-6jbupg3thjwhsabgevk6xmwhd2bbyxdc/bin/mpicc \
--with-cxx=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/spectrum-mpi-10.4.0.3-20210112-6jbupg3thjwhsabgevk6xmwhd2bbyxdc/bin/mpicxx \
--with-fc=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/spectrum-mpi-10.4.0.3-20210112-6jbupg3thjwhsabgevk6xmwhd2bbyxdc/bin/mpif90 \
--with-fortran-bindings=1 \
--with-mpiexec="jsrun -g 6 --smpiargs=-gpu " \
--with-batch=0 \
--download-kokkos \
--download-kokkos-kernels \
--with-kokkos-kernels-tpl=0 \
--with-make-np=8 \
--with-netcdf-dir=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/netcdf-c-4.8.0-dk4dnwusxpppb4cqc2hql4iyawq7v3qp \
--with-pnetcdf-dir=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/parallel-netcdf-1.12.2-nse25ebg555xg2kft27irq6hpqi5jycm \
--with-hdf5-dir=/sw/summit/spack-envs/base/opt/linux-rhel8-ppc64le/gcc-9.1.0/hdf5-1.10.7-yxvwkhm4nhgezbl2mwzdruwoaiblt6q2 \
--with-cuda-dir=/sw/summit/cuda/11.0.3 \
--download-parmetis \
--download-metis \
--download-zlib \
--download-scalapack \
--download-sowing \
--download-triangle \
--download-exodusii \
--download-libceed \
--with-debugging=1 \
PETSC_ARCH=summit-gpu-debug-gcc-9-1-0

