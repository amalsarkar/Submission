
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1897.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1898.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1899.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1900.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1901.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1902.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1903.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1904.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1905.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1906.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1907.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1908.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1909.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1910.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0001/OutTree_1911.root -out SingleMuon_Run2016B_23Sep2016_v3_fix3_116.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016B_23Sep2016_v3_fix3_116.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016B_23Sep2016_v3_fix3/SingleMuon_Run2016B_23Sep2016_v3_fix3_116.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
