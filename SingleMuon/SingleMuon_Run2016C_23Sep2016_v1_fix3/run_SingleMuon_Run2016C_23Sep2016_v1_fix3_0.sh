
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_1.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_10.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_100.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_101.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_102.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_103.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_104.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_105.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_106.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_107.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_108.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_109.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_11.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_110.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_111.root -out SingleMuon_Run2016C_23Sep2016_v1_fix3_0.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016C_23Sep2016_v1_fix3_0.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016C_23Sep2016_v1_fix3/SingleMuon_Run2016C_23Sep2016_v1_fix3_0.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
