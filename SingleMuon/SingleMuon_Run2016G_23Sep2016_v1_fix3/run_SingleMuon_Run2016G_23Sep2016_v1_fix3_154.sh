
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2274.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2275.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2276.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2277.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2278.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2279.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2280.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2281.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2282.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2283.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2284.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2285.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2286.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2287.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016G_23Sep2016_v1_fix3/170309_214743/0002/OutTree_2288.root -out SingleMuon_Run2016G_23Sep2016_v1_fix3_154.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016G_23Sep2016_v1_fix3_154.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016G_23Sep2016_v1_fix3/SingleMuon_Run2016G_23Sep2016_v1_fix3_154.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
