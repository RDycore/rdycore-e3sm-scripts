#!/bin/sh

source ../modules/modules.pm-cpu.gnu

./configure \
--with-cc=cc \
--with-cxx=CC \
--with-fc=ftn \
--CFLAGS=" -g " \
--CXXFLAGS=" -g " \
--CUDAFLAGS=" -g -Xcompiler -rdynamic " \
--with-fortran-bindings=1 \
--COPTFLAGS="   -O" \
--CXXOPTFLAGS=" -O" \
--FOPTFLAGS="   -O" \
--with-mpiexec="srun -G4" \
--with-batch=0 \
--download-kokkos \
--download-kokkos-kernels \
--with-kokkos-kernels-tpl=0 \
--with-make-np=8 \
--with-64-bit-indices=0 \
--with-netcdf-dir=/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1 \
--with-pnetcdf-dir=/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1 \
--with-hdf5-dir=/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1 \
--with-cuda-dir=/opt/nvidia/hpc_sdk/Linux_x86_64/21.11/cuda/11.5 \
--with-cuda-arch=80 \
--download-parmetis \
--download-metis \
--download-zlib \
--download-scalapack \
--download-sowing \
--download-triangle \
--download-exodusii \
--download-libceed \
--with-debugging=1 \
PETSC_ARCH=arch-pm-gpu-debug-gcc-11-2-0

