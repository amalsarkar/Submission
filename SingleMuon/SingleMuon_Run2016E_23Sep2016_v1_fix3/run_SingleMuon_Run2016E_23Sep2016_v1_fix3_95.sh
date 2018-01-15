
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1413.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1414.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1415.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1416.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1417.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1418.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1419.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1420.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1421.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1422.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1423.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1424.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1425.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1426.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1427.root -out SingleMuon_Run2016E_23Sep2016_v1_fix3_95.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016E_23Sep2016_v1_fix3_95.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016E_23Sep2016_v1_fix3/SingleMuon_Run2016E_23Sep2016_v1_fix3_95.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
