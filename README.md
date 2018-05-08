# PRIMA_CLM4
CLM4 configuration and driving scripts under the PRIMA Initiative (https://im3.pnnl.gov/platform-regional-integrated-modeling-and-analysis-prima)

Repository for driving scripts and CLM4 NLDAS compsets (hist, RCP4.5, RCP8.5) developed under the PRIMA initiative, to be used on PNNL Institutional Computing facility, Constance

## Repository structure

---shell | ---inputdata

## Tutorial to configure the PRIMA CLM4 HIST, RCP4.5, and RCP8.5 cases
We provide detailed notes on running the CLM4 compsets on PIC Constance cluster.

### Download code repository

#### CLM code
##### Please check http://www.cesm.ucar.edu/models/ccsm4.0/index.html for instructions for downloading a released CLM4 version
```
setenv BASE_DIR <directory-of-choice>
cd $BASE_DIR
svn co https://svn-ccsm-release.cgd.ucar.edu/model_versions/ccsm4_0_rel03 clm4
setenv CLM_SRC_DIR $BASE_DIR/clm4
cd $CLM_SRC_DIR
```

### Download data repository
```
cd $BASE_DIR
mkdir CESM_cases
git clone git@github.com:IMMM-SFA/PRIMA_CLM4.git
setenv CASE_DIR $BASE_DIR/cases
cd $BASE_DIR/clm-pflotran-scripts
setenv INPUTDATA_DIR ${PWD}/datasets
```

#### Download data from NCAR repo, instruction for registration can be found at http://www.cesm.ucar.edu/models/cesm1.2

```

```

## Who do I talk to?
    maoyi.huang at pnnl.gov

## Reference:
Kraucunas IP, LE Clarke, JA Dirks, JE Hathaway, MI Hejazi, KA Hibbard, M Huang, C Jin, MCW Kintner-Meyer, K Kleese van Dam, LYR Leung, H Li, RH Moss, MJ Peterson, JS Rice, MJ Scott, AM Thomson, N Voisin, and TO West. 2015. "Investigating the Nexus of Climate, Energy, Water, and Land at Decision-Relevant Scales: The Platform for Regional Integrated Modeling and Analysis (PRIMA)." Climatic Change 129(3-4):573-588.  doi:10.1007/s10584-014-1064-9

Hejazi MI, N Voisin, L Liu, LM Bramer, DC Fortin, JE Hathaway, M Huang, GP Kyle, LYR Leung, H Li, Y Liu, PL Patel, TC Pulsipher, JS Rice, TK Tesfa, CR Vernon, and Y Zhou. 2015. "21st Century United States Emissions Mitigation Could Increase Water Stress more than the Climate Change it is Mitigating." Proceedings of the National Academy of Sciences of the United States of America 112(34):10635-10640.  doi:10.1073/pnas.1421675112
