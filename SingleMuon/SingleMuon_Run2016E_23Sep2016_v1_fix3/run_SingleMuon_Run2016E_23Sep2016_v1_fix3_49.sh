
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_758.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_759.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_76.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_760.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_761.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_762.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_763.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_764.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_765.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_766.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_767.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_768.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_769.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_77.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_770.root -out SingleMuon_Run2016E_23Sep2016_v1_fix3_49.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016E_23Sep2016_v1_fix3_49.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016E_23Sep2016_v1_fix3/SingleMuon_Run2016E_23Sep2016_v1_fix3_49.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
