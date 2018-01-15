
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1460.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1461.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1462.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1463.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1464.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1465.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1466.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1467.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1468.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1469.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1470.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1471.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1472.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1473.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1474.root -out SingleMuon_Run2016D_23Sep2016_v1_fix3_97.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016D_23Sep2016_v1_fix3_97.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016D_23Sep2016_v1_fix3/SingleMuon_Run2016D_23Sep2016_v1_fix3_97.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
