
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1928.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1929.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1930.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1931.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1932.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1933.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1934.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1935.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1936.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1937.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1938.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1939.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1940.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1941.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1942.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1943.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1944.root -out SingleMuon_Run2016B_23Sep2016_v3_fix3_118.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016B_23Sep2016_v3_fix3_118.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016B_23Sep2016_v3_fix3/SingleMuon_Run2016B_23Sep2016_v3_fix3_118.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
