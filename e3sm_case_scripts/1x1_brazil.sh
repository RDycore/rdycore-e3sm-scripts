#!/bin/sh

SRC_DIR=$PWD

RES=1x1_brazil
COMPSET=IELM
MACH=crusher
MACH=summit
MACH=pm-gpu
MACH=pm-cpu
MACH=frontier

case $MACH in

  "crusher")
    echo "OLCF Crusher"
    E3SM_DIR=/ccs/home/gb9/Projects/e3sm
    COMPILER=gnugpu
    PROJECT=csc314
    source petsc/petsc.$MACH.$COMPILER
    source modules/modules.$MACH.$COMPILER
    ;;

  summit)
    echo "OLCF Summit"
    E3SM_DIR=/ccs/home/gb9/Projects/e3sm
    COMPILER=gnugpu
    PROJECT=csc314
    source petsc/petsc.$MACH.$COMPILER
    source modules/modules.$MACH.$COMPILER
    ;;

  pm-gpu)
    echo "Perlmutter GPU"
    E3SM_DIR=/global/cfs/projectdirs/m4267/gbisht/e3sm
    COMPILER=gnugpu
    PROJECT=m4267
    source petsc/petsc.$MACH.$COMPILER
    source modules/modules.$MACH.$COMPILER
    ;;

  pm-cpu)
    echo "Perlmutter CPU"
    E3SM_DIR=/global/cfs/projectdirs/m4267/gbisht/e3sm
    COMPILER=gnu
    PROJECT=m4267
    source petsc/petsc.$MACH.$COMPILER
    source modules/modules.$MACH.$COMPILER
    ;;

  frontier)
    echo "Fontier GPU"
    E3SM_DIR=/ccs/home/gb9/Projects/e3sm/
    COMPILER=gnugpu
    PROJECT=csc314
    source petsc/petsc.$MACH.$COMPILER
    source modules/modules.$MACH.$COMPILER
    ;;

  *)
    echo "Stopping because this is an unknown machine"
    exit 1;
    ;;

esac

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Compile RDycore
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cd $E3SM_DIR/externals/rdycore
git submodule update --init
RDYCORE_BUILD_DIR=$PWD/build-$PETSC_ARCH
mkdir $RDYCORE_BUILD_DIR
cd $RDYCORE_BUILD_DIR
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD -DCMAKE_BUILD_TYPE=Debug
make -j4
make -j4 install


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Create an E3SM case
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cd $E3SM_DIR
GIT_HASH=`git log -n 1 --format=%h`

CASE_NAME=${RES}.${COMPSET}.${MACH}.${COMPILER}.${GIT_HASH}.`date "+%Y-%m-%d"`

cd ${E3SM_DIR}/cime/scripts

CASE_DIR=${E3SM_DIR}/cime/scripts

./create_newcase -case ${CASE_DIR}/${CASE_NAME} \
-res ${RES} -compset ${COMPSET} -mach ${MACH} -compiler ${COMPILER} -project ${PROJECT}

cd $CASE_DIR/$CASE_NAME

case $MACH in
  "crusher")
    ./xmlchange CIME_OUTPUT_ROOT=/gpfs/alpine/${PROJECT}/proj-shared/gb9/e3sm_scratch/crusher
    ./xmlchange JOB_WALLCLOCK_TIME=00:20:00
    ./xmlchange run_exe="\${EXEROOT}/e3sm.exe -dm_mat_type aijkokkos -dm_vec_type kokkos -log_view_gpu_time -log_view "
    ;;

  "summit")
    ./xmlchange JOB_WALLCLOCK_TIME=00:20
    ./xmlchange CHARGE_ACCOUNT=$PROJ
    ./xmlchange run_exe="\${EXEROOT}/e3sm.exe -dm_mat_type aijkokkos -dm_vec_type kokkos -log_view_gpu_time -log_view "
    ;;

  "pm-gpu")
    ./xmlchange run_exe="\${EXEROOT}/e3sm.exe -dm_mat_type aijkokkos -dm_vec_type kokkos -log_view_gpu_time -log_view "
    ./xmlchange JOB_WALLCLOCK_TIME=00:20:00
    ;;

  "pm-cpu")
    ./xmlchange JOB_WALLCLOCK_TIME=00:20:00
    ;;

  "frontier")
    ./xmlchange CIME_OUTPUT_ROOT=/lustre/orion/csc314/proj-shared/gb9/e3sm_scratch/$MACH
    ./xmlchange SAVE_TIMING_DIR=/lustre/orion/csc314/proj-shared/gb9/e3sm_scratch/$MACH
    ./xmlchange JOB_WALLCLOCK_TIME=00:20:00
    ./xmlchange run_exe="\${EXEROOT}/e3sm.exe -dm_mat_type aijkokkos -dm_vec_type kokkos -log_view_gpu_time -log_view "
    ;;

  *)
    echo "Stopping because this is an unknown machine"
    exit 1;
    ;;
esac

./xmlchange NTASKS=1


cp $SRC_DIR/Macros/Macros.cmake.$MACH.$COMPILER Macros.cmake
./case.setup
#./case.build


# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Copy RDycore files 
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUNDIR=`./xmlquery RUNDIR`
cp $RDYCORE_BUILD_DIR/driver/tests/swe_roe/ex2b.yaml $RUNDIR/
cp $RDYCORE_BUILD_DIR/driver/tests/swe_roe/planar_dam_10x5.msh $RUNDIR/
mkdir -p $RUNDIR/output

