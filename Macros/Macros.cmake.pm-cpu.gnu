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


string(APPEND FFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/include -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.3/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.3/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.3/gnu/9.1/include ")
string(APPEND CFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/include -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.3/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.3/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.3/gnu/9.1/include ")
string(APPEND CPPFLAGS " -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/include -I/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.3/gnu/9.1/include -I/opt/cray/pe/parallel-netcdf/1.12.3.3/gnu/9.1/include -I/opt/cray/pe/hdf5-parallel/1.12.2.3/gnu/9.1/include ")

string(APPEND FFLAGS " -I/global/cfs/projectdirs/m4267/gbisht/e3sm/externals/rdycore/build-pm-cpu-gcc-11-2-0/include ")
string(APPEND SLIBS " /global/cfs/projectdirs/m4267/gbisht/e3sm/externals/rdycore/build-pm-cpu-gcc-11-2-0/lib/librdycore.a ")
string(APPEND SLIBS " /global/cfs/projectdirs/m4267/gbisht/e3sm/externals/rdycore/build-pm-cpu-gcc-11-2-0/lib/librdycore_f90.a ")
string(APPEND SLIBS " /global/cfs/projectdirs/m4267/gbisht/e3sm/externals/rdycore/build-pm-cpu-gcc-11-2-0/lib/libcyaml.a ")
string(APPEND SLIBS " /global/cfs/projectdirs/m4267/gbisht/e3sm/externals/rdycore/build-pm-cpu-gcc-11-2-0/lib/libyaml.a ")

string(APPEND SLIBS "  -Wl,-rpath,/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/lib -L/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/lib -Wl,-rpath,/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/lib -L/global/cfs/projectdirs/m4267/petsc/petsc_99e66fd4349/pm-cpu-gcc-11-2-0/lib -Wl,-rpath,/opt/cray/pe/netcdf-hdf5parallel/4.9.0.3/gnu/9.1/lib -L/opt/cray/pe/netcdf-hdf5parallel/4.9.0.3/gnu/9.1/lib -Wl,-rpath,/opt/cray/pe/parallel-netcdf/1.12.3.3/gnu/9.1/lib -L/opt/cray/pe/parallel-netcdf/1.12.3.3/gnu/9.1/lib -Wl,-rpath,/opt/cray/pe/hdf5-parallel/1.12.2.3/gnu/9.1/lib -L/opt/cray/pe/hdf5-parallel/1.12.2.3/gnu/9.1/lib -lpetsc -lscalapack -lparmetis -lmetis -lexoIIv2for32 -lexodus -lnetcdf -lpnetcdf -lhdf5_hl -lhdf5 -ltriangle -lz -lceed -lX11 -lstdc++ -lquadmath")



