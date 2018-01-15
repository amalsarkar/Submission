
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_427.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_428.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_429.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_43.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_430.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_431.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_432.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_433.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_434.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_435.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_436.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_437.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_438.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_439.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0000/OutTree_44.root -out SingleMuon_Run2016G_23Sep2016_v1_fix3_25.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016G_23Sep2016_v1_fix3_25.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016G_23Sep2016_v1_fix3/SingleMuon_Run2016G_23Sep2016_v1_fix3_25.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
