
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_416.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_417.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_418.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_419.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_42.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_420.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_421.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_422.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_423.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_424.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_425.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_426.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_427.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_428.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_429.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_43.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_430.root -out SingleMuon_Run2016B_23Sep2016_v3_fix3_22.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016B_23Sep2016_v3_fix3_22.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016B_23Sep2016_v3_fix3/SingleMuon_Run2016B_23Sep2016_v3_fix3_22.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
