#
# Use this file to include the relevant macros based on
# machine/compiler settings. This file gets copied to CASEROOT
# and that's the one that gets included by the build system. Feel free
# to modify this file in the CASEROOT.
#
cmake_policy(SET CMP0057 NEW)

set(MACROS_DIR ${CASEROOT}/cmake_macros)

set(UNIVERSAL_MACRO ${MACROS_DIR}/universal.cmake)
set(COMPILER_MACRO ${MACROS_DIR}/${COMPILER}.cmake)
set(OS_MACRO ${MACROS_DIR}/${OS}.cmake)
set(MACHINE_MACRO ${MACROS_DIR}/${MACH}.cmake)
set(COMPILER_OS_MACRO ${MACROS_DIR}/${COMPILER}_${OS}.cmake)
set(COMPILER_MACHINE_MACRO ${MACROS_DIR}/${COMPILER}_${MACH}.cmake)

if (CONVERT_TO_MAKE)
  get_cmake_property(VARS_BEFORE_BUILD_INTERNAL_IGNORE VARIABLES)
endif()

# Include order defines precedence
foreach (MACRO_FILE ${UNIVERSAL_MACRO} ${COMPILER_MACRO} ${OS_MACRO} ${MACHINE_MACRO} ${COMPILER_OS_MACRO} ${COMPILER_MACHINE_MACRO})
  if (EXISTS ${MACRO_FILE})
    include(${MACRO_FILE})
  else()
    message("No macro file found: ${MACRO_FILE}")
  endif()
endforeach()

if (CONVERT_TO_MAKE)
  get_cmake_property(VARS_AFTER VARIABLES)

  foreach (VAR_AFTER IN LISTS VARS_AFTER)
    if (NOT VAR_AFTER IN_LIST VARS_BEFORE_BUILD_INTERNAL_IGNORE)
      message("CIME_SET_MAKEFILE_VAR ${VAR_AFTER} := ${${VAR_AFTER}}")
    endif()
  endforeach()
endif()

string(APPEND FFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/include -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1/include ")
string(APPEND CFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/include -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1/include ")
string(APPEND CPPFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/include -I/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1/include ")
string(APPEND FFLAGS " -I/global/cfs/projectdirs/m4267/gbisht/rdycore/build-arch-pm-cpu-debug-gcc-11-2-0/include ")
string(APPEND SLIBS " -L/global/cfs/projectdirs/m4267/gbisht/rdycore/build-arch-pm-cpu-debug-gcc-11-2-0/lib -lrdycore -lrdycore_f90 -lyaml ")

string(APPEND SLIBS " -fPIC -Wall -ffree-line-length-none -ffree-line-length-0 -Wno-lto-type-mismatch -Wno-unused-dummy-argument -O  ")
string(APPEND SLIBS " -Wl,-rpath,/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/lib -L/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/lib -Wl,-rpath,/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/lib -L/global/cfs/projectdirs/m4267/petsc/petsc_v3.18.4/arch-pm-cpu-debug-gcc-11-2-0/lib -Wl,-rpath,/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1/lib -L/opt/cray/pe/netcdf-hdf5parallel/4.9.0.1/gnu/9.1/lib -Wl,-rpath,/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1/lib -L/opt/cray/pe/parallel-netcdf/1.12.3.1/gnu/9.1/lib -Wl,-rpath,/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1/lib -L/opt/cray/pe/hdf5-parallel/1.12.2.1/gnu/9.1/lib -lpetsc -lscalapack -lexoIIv2for32 -lexodus -lnetcdf -lpnetcdf -lhdf5_hl -lhdf5 -lparmetis -lmetis -ltriangle -lz -lceed -lX11 -lquadmath -lstdc++ -ldl  ")


