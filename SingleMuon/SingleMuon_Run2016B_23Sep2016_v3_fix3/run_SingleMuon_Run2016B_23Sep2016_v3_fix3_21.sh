
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_40.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_400.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_401.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_402.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_403.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_404.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_405.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_406.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_407.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_408.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_409.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_41.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_410.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_411.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_412.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_413.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_414.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_415.root -out SingleMuon_Run2016B_23Sep2016_v3_fix3_21.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016B_23Sep2016_v3_fix3_21.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016B_23Sep2016_v3_fix3/SingleMuon_Run2016B_23Sep2016_v3_fix3_21.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
