# PRIMA_CLM4
CLM4 configuration and driving scripts under the PRIMA Initiative (https://im3.pnnl.gov/platform-regional-integrated-modeling-and-analysis-prima)

Repository for driving scripts and CLM4 NLDAS compsets (hist, RCP4.5, RCP8.5) developed under the PRIMA initiative, to be used on PNNL Institutional Computing facility, Constance

## Repository structure

---scripts/shell | ---inputdata

## Tutorial to configure the PRIMA CLM4 HIST, RCP4.5, and RCP8.5 cases
We provide detailed notes on running the CLM4 compsets on PIC Constance cluster.

### Download script, data, and code repositories
#### Download script and data repository
```
setenv BASE_DIR <directory-of-choice>
cd $BASE_DIR
mkdir cases
git clone git@github.com:IMMM-SFA/PRIMA_CLM4.git
setenv CASE_DIR $BASE_DIR/cases
setenv INPUTDATA_DIR $BASE_DIR/PRIMA_CLM4/inputdata
```
#### Download CLM code, please check http://www.cesm.ucar.edu/models/ccsm4.0/index.html for instructions to download a released CLM4 version
```
cd $BASE_DIR
svn co https://svn-ccsm-release.cgd.ucar.edu/model_versions/ccsm4_0_rel03 clm4
setenv CLM_SRC_DIR $BASE_DIR/clm4
cd $CLM_SRC_DIR
```
#### Download data from NCAR repo, instruction for registration can be found at http://www.cesm.ucar.edu/models/cesm1.2

```
svn export https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2/pftdata/pft-physiology.c100226 ${INPUTDATA_DIR}/cesm_inputdata/lnd/clm2/pftdata/pft-physiology.c100226
svn export https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2/snicardata/snicar_drdt_bst_fit_60_c070416.nc ${INPUTDATA_DIR}/cesm_inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc
svn export https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc ${INPUTDATA_DIR}/cesm_inputdata/lnd/clm2/snicardata/snicar_optics_5bnd_c090915.nc
svn export https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/lnd/clm2/rtmdata/rdirc.05.061026 ${INPUTDATA_DIR}/cesm_inputdata/lnd/clm2/rtmdata/rdirc.05.061026
```
#### Download the NLDAS input datasets from https://dtn2.pnl.gov/data/im3/PRIMA/CLM 
#### NOTE: NOT NECESSARY on Constance as symbolic links exist
```
 Download data from https://dtn2.pnl.gov/data/im3/PRIMA/CLM/forcing 
               and save to $INPUTDATA_DIR/user_inputdata/nldas2_forcing
 Download data from https://dtn2.pnl.gov/data/im3/PRIMA/CLM/inputdata 
               and save to $INPUTDATA_DIR/user_inputdata/nldas2_clm4
```
#### Configure the PRIMA CLM4 historical simulation
```
setenv PERIOD hist
cd $BASE_DIR/PRIMA_CLM4/scripts/shell
./setup_prima_clm4_hist.sh
cd $CASE_DIR/clm4_nldas_hist
```
#### Configure the PRIMA CLM4 RCP4.5 simulation
```
setenv PERIOD rcp45
cd $BASE_DIR/PRIMA_CLM4/scripts/shell
./setup_prima_clm4_rcp45.sh
cd $CASE_DIR/clm4_nldas_rcp45
```
#### Configure the PRIMA CLM4 RCP8.5 simulation
```
setenv PERIOD rcp85
cd $BASE_DIR/PRIMA_CLM4/scripts/shell
./setup_prima_clm4_rcp85.sh
cd $CASE_DIR/clm4_nldas_rcp85
```
## Who do I talk to?
    maoyi.huang at pnnl.gov

## Description of the PRIMA CLM4 compsets 
### Note: associated datasets can be found at https://dtn2.pnl.gov/data/im3/PRIMA/CLM
The RESM simulations (Ke et al., 2012; Gao et al., 2014; Kraucunas et al. 2015) were postprocessed using bias correction to provide meteorological forcing for offline simulations using version 4 of the Community Land Model (CLM) (Oleson et al., 2010) at a resolution of one-eighth of a degree. The bias correction followed the method described by Wood et al. (2004). Data input to CLM, such as land cover, soil properties, and vegetation phenology, were retrieved from datasets developed by Ke et al. (2012) at a resolution of 0.05# and were aggregated to a resolution of one-eighth of a degree. CLM was spun up by recycling the meteorological forcing over the historical period (1975-2004) until all state variables, including soil moisture, soil temperature, and groundwater table depth, reached equilibrium.Then the model was forced by the two bias-corrected RESM downscaled climate scenarios, RCP4.5 and RCP8.5, to simulate terrestrial hydrological states and fluxes from 2005-2100. 

## Reference:
Kraucunas IP, LE Clarke, JA Dirks, JE Hathaway, MI Hejazi, KA Hibbard, M Huang, C Jin, MCW Kintner-Meyer, K Kleese van Dam, LYR Leung, H Li, RH Moss, MJ Peterson, JS Rice, MJ Scott, AM Thomson, N Voisin, and TO West. 2015. "Investigating the Nexus of Climate, Energy, Water, and Land at Decision-Relevant Scales: The Platform for Regional Integrated Modeling and Analysis (PRIMA)." Climatic Change 129(3-4):573-588.  doi:10.1007/s10584-014-1064-9

Hejazi MI, N Voisin, L Liu, LM Bramer, DC Fortin, JE Hathaway, M Huang, GP Kyle, LYR Leung, H Li, Y Liu, PL Patel, TC Pulsipher, JS Rice, TK Tesfa, CR Vernon, and Y Zhou. 2015. "21st Century United States Emissions Mitigation Could Increase Water Stress more than the Climate Change it is Mitigating." Proceedings of the National Academy of Sciences of the United States of America 112(34):10635-10640.  doi:10.1073/pnas.1421675112

## Additional References:
Ke Y, et al. (2012) Development of High Resolution Land Surface Parameters for the Community Land Model. Geoscientific Model Development 5(6):1341-1362

Oleson KW, et al. (2010) Technical Description of version 4.0 of the Community Land Model (CLM). NCAR Technical Note NCAR/TN-478+STR (National Center for Atmospheric Research, Boulder, CO), 257 pp

Wood A, Leung L, Sridhar V, Lettenmaier D (2004) Hydrologic implications of dynamical and statistical approaches to downscaling climate model outputs. Clim Change 62(1-3):189-216

Gao Y, LYR Leung, J Lu, Y Liu, M Huang, and Y Qian. 2014. "Robust Spring Drying in the Southwestern U.S. and Seasonal Migration of Wet/Dry Patterns in a Warmer Climate ." Geophysical Research Letters 41:1745-1751.  doi:10.1002/2014GL059562

## Recommended acknowledgement for using the compsets and driving scripts:
The authors would like to acknowledge M. Huang at Pacific Northwest National Laboratory (PNNL) for sharing the PRIMA CLM4 compsets and driving scripts, supported by the Platform for Regional Integrated Modeling and Analysis (PRIMA) Initiative and the U.S. Department of Energy, Office of Science as part of research in Multi-Sector Dynamics, Earth and Environmental System Modeling Program.
