
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_128.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_129.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_13.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_130.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_131.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_132.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_133.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_134.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_135.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_136.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_137.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_138.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_139.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_14.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_140.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_141.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016B_23Sep2016_v3_fix3/170309_214518/0000/OutTree_142.root -out SingleMuon_Run2016B_23Sep2016_v3_fix3_2.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016B_23Sep2016_v3_fix3_2.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016B_23Sep2016_v3_fix3/SingleMuon_Run2016B_23Sep2016_v3_fix3_2.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
