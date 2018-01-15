
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1034.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1035.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1036.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1037.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1038.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1039.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1040.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1041.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1042.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1043.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1044.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1045.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1046.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1047.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0001/OutTree_1048.root -out SingleMuon_Run2016F_23Sep2016_v1_fix3_70.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016F_23Sep2016_v1_fix3_70.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016F_23Sep2016_v1_fix3/SingleMuon_Run2016F_23Sep2016_v1_fix3_70.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
