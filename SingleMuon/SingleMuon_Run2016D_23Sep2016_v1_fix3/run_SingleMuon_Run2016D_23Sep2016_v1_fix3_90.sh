
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1355.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1356.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1357.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1358.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1359.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1360.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1361.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1362.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1363.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1364.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1365.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1366.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1367.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1368.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1369.root -out SingleMuon_Run2016D_23Sep2016_v1_fix3_90.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016D_23Sep2016_v1_fix3_90.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016D_23Sep2016_v1_fix3/SingleMuon_Run2016D_23Sep2016_v1_fix3_90.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
