
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_191.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_192.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_193.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_194.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_195.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_196.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_197.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_198.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_199.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_2.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_20.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_200.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_201.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_202.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016E_23Sep2016_v1_fix3/170309_214637/0000/OutTree_203.root -out SingleMuon_Run2016E_23Sep2016_v1_fix3_7.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016E_23Sep2016_v1_fix3_7.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016E_23Sep2016_v1_fix3/SingleMuon_Run2016E_23Sep2016_v1_fix3_7.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
