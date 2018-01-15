
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1392.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1393.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1394.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1395.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1396.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1397.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1398.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1399.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1400.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1401.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1402.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1403.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1404.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1405.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0001/OutTree_1406.root -out SingleMuon_Run2016G_23Sep2016_v1_fix3_94.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016G_23Sep2016_v1_fix3_94.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016G_23Sep2016_v1_fix3/SingleMuon_Run2016G_23Sep2016_v1_fix3_94.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
