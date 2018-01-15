
#!/bin/bash -e
sleep $[ ( $RANDOM % 30 ) ]
date

cd ${_CONDOR_SCRATCH_DIR}
tar -xvzf exe.tar.gz
ls
isData=false
echo $isData

if [ ! -z $isData ]
then
    echo "switch data to true"
    sed -r -i -e 's/(isData\s+)(0|false)/isData true/' -e 's/(CalculatePUS[a-z]+\s+)(1|true)/CalculatePUSystematics false/' 	PartDet/Run_info.in
else
    echo "switch data to false"
    sed -r -i -e 's/(isData\s+)(1|true)/isData false/' -e 's/(CalculatePUS[a-z]+\s+)(0|false)/CalculatePUSystematics true/' 	PartDet/Run_info.in
fi

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_30.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_300.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_301.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_302.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_303.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_304.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_305.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_306.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_307.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_308.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_309.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_31.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_310.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_311.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_312.root -out SingleMuon_Run2016F_23Sep2016_v1_fix3_15.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016F_23Sep2016_v1_fix3_15.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016F_23Sep2016_v1_fix3/SingleMuon_Run2016F_23Sep2016_v1_fix3_15.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
