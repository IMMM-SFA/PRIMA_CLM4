#!/bin/sh
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Driving script for the PRIMA CLM4 HIST (1975-2004) simulation
# Maoyi Huang, 05/08/2018
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
export CESM_CASE_DIR=${BASE_DIR}/cases
export CESM_SRC_DIR=${BASE_DIR}/clm4
export INPUTDATA_DIR=${BASE_DIR}/PRIMA_CLM4/inputdata
export CESM_INPUTDATA_DIR=${INPUTDATA_DIR}/cesm_inputdata
export CESM_COMPSET=NLDAS
export RUNDIR=/pic/scratch/${USER}

export CLM_USRDAT_NAME=nldas2_0224x0464
export DOMAINFILE_CYYYYMMDD=c110415
export SURFFILE_CYYYYMMDD=c131007
export CESM_CASE_NAME=clm4_nldas_hist
export YEAR_START=1975
export YEAR_END=2004

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Create soft links for CESM inputdata
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

mkdir -p ${CESM_INPUTDATA_DIR}/atm/datm7/${CLM_USRDAT_NAME}
rm -rf ${CESM_INPUTDATA_DIR}/atm/datm7/${CLM_USRDAT_NAME}/*.nc
ls -l ${INPUTDATA_DIR}/user_inputdata/nldas2_forcing/clmforc_hist/*.nc | awk '{ print $9}' | awk -F'.' '{print $3}' | \
awk -v INPUTDATA_DIR=${INPUTDATA_DIR} -v CLM_USRDAT_NAME=${CLM_USRDAT_NAME} \
'{ system( "ln -s " INPUTDATA_DIR "/user_inputdata/nldas2_forcing/clmforc_hist/clmforc.nldas." $1 ".nc " INPUTDATA_DIR"/cesm_inputdata/atm/datm7/"CLM_USRDAT_NAME"/clmforc.nldas." $1 ".nc") }'

mkdir -p ${CESM_INPUTDATA_DIR}/atm/datm7/domain.clm
rm -rf ${CESM_INPUTDATA_DIR}/atm/datm7/domain.clm/domain.lnd.${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc
ln -s ${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/domain.lnd.${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc ${CESM_INPUTDATA_DIR}/atm/datm7/domain.clm/domain.lnd.${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc

rm -rf ${CESM_INPUTDATA_DIR}/lnd/clm2/snicardata/aerosoldep_2000_mean_nldas2_c110420.nc
ln -s ${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/aerosoldep_2000_mean_nldas2_c110420.nc ${CESM_INPUTDATA_DIR}/lnd/clm2/snicardata/aerosoldep_2000_mean_nldas2_c110420.nc

mkdir -p ${CESM_INPUTDATA_DIR}/lnd/clm2/surfdata/
rm -rf ${CESM_INPUTDATA_DIR}/lnd/clm2/surfdata/surfdata_${CLM_USRDAT_NAME}_${SURFFILE_CYYYYMMDD}.nc
ln -s ${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/surfdata_${CLM_USRDAT_NAME}_${SURFFILE_CYYYYMMDD}.nc ${CESM_INPUTDATA_DIR}/lnd/clm2/surfdata/surfdata_${CLM_USRDAT_NAME}_${SURFFILE_CYYYYMMDD}.nc

mkdir -p ${CESM_INPUTDATA_DIR}/lnd/clm2/griddata
rm -rf ${CESM_INPUTDATA_DIR}/lnd/clm2/griddata/griddata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc
rm -rf ${CESM_INPUTDATA_DIR}/lnd/clm2/griddata/fracdata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc
ln -s ${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/griddata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc ${CESM_INPUTDATA_DIR}/lnd/clm2/griddata/griddata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc
ln -s ${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/fracdata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc  ${CESM_INPUTDATA_DIR}/lnd/clm2/griddata/fracdata_${CLM_USRDAT_NAME}_${DOMAINFILE_CYYYYMMDD}.nc

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Modify the Machine files to include Constance
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/Machines/* ${BASE_DIR}/clm4/scripts/ccsm_utils/Machines

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Modify the Case.template and namelist files for the NLDAS compset
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/Case.template/* ${BASE_DIR}/clm4/scripts/ccsm_utils/Case.template/
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/namelist_files/namelist_defaults_*.xml ${BASE_DIR}/clm4/models/lnd/clm/bld/namelist_files/
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/namelist_files/namelist_definition.xml ${BASE_DIR}/clm4/models/lnd/clm/bld/namelist_files/
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/namelist_files/datm.template.streams.xml ${BASE_DIR}/clm4/models/atm/datm/bld/
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/namelist_files/datm.cpl7.template ${BASE_DIR}/clm4/models/atm/datm/bld/

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Now do the CLM stuff
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd ${CESM_SRC_DIR}/scripts

# Creating case with command :
./create_newcase -case ${CESM_CASE_DIR}/${CESM_CASE_NAME} -res ${CESM_COMPSET} -compset ${CESM_COMPSET} -mach constance 

# Configuring case :
cd ${CESM_CASE_DIR}/${CESM_CASE_NAME}

# Create Macros
# Modifying : env_mach_pes.xml
./xmlchange -file env_mach_pes.xml -id NTASKS_ATM -val 24
./xmlchange -file env_mach_pes.xml -id NTASKS_LND -val 192
./xmlchange -file env_mach_pes.xml -id NTASKS_CPL -val 24

# Modifying : env_conf.xml
./xmlchange -file env_conf.xml -id DATM_CLMNCEP_YR_END -val ${YEAR_END}
./xmlchange -file env_conf.xml -id RUN_STARTDATE -val ${YEAR_START}-01-01
./xmlchange -file env_conf.xml -id DATM_CLMNCEP_YR_START -val ${YEAR_START}
./xmlchange -file env_conf.xml -id DATM_CLMNCEP_YR_ALIGN -val ${YEAR_START}
./xmlchange -file env_conf.xml -id DATM_MODE -val CLMNLDAS

# Modifying : env_run.xml
./xmlchange -file env_run.xml -id STOP_N -val 30
./xmlchange -file env_run.xml -id STOP_OPTION -val nyears
./xmlchange -file env_run.xml -id DIN_LOC_ROOT -val ${CESM_INPUTDATA_DIR}
./xmlchange -file env_run.xml -id DIN_LOC_ROOT_CSMDATA -val ${CESM_INPUTDATA_DIR}
./xmlchange -file env_run.xml -id DOUT_S -val TRUE
./xmlchange -file env_run.xml -id DOUT_S_ROOT -val ${RUNDIR}/archive/${CESM_CASE_NAME}
./xmlchange -file env_run.xml -id RUNDIR -val ${RUNDIR}/${CESM_CASE_NAME}/run

# Modify user_nl_clm
export fclmi=${INPUTDATA_DIR}/user_inputdata/nldas2_clm4/clm_nldas2_hist.clm2.r.1980-01-01-00000.nc
cat >> user_nl_clm << EOF
&clm_inparm
dtime       = 1800
finidat     = '${fclmi}'
hist_mfilt  = 1, 2920
hist_nhtfrq = 0, -3
hist_fincl2 = 'QOVER','QDRAI','QRUNOFF'
outnc_large_files              = .true.
rtm_nsteps             = 6
/
EOF

# Configuring the case
./configure -case

#add user created source codes
cp -f ${BASE_DIR}/PRIMA_CLM4/scripts/shell/user_Mods/clm4_0/ncdio.F90 ${CESM_CASE_DIR}/${CESM_CASE_NAME}/SourceMods/src.clm/ncdio.F90

# Build the case
./${CESM_CASE_NAME}.constance.build

# Running case :
#sbatch ${CESM_CASE_NAME}.constance.run 

