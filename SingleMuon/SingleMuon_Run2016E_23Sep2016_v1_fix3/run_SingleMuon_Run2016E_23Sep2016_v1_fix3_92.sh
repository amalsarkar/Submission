
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1369.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1370.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1371.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1372.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1373.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1374.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1375.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1376.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1377.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1378.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1379.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1380.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1381.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1382.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0001/OutTree_1383.root -out SingleMuon_Run2016E_23Sep2016_v1_fix3_92.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016E_23Sep2016_v1_fix3_92.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016E_23Sep2016_v1_fix3/SingleMuon_Run2016E_23Sep2016_v1_fix3_92.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
