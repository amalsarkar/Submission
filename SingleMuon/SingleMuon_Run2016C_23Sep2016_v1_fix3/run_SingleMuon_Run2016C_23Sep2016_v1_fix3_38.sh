
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_622.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_623.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_624.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_625.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_626.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_627.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_628.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_629.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_63.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_630.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_631.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_632.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_633.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_634.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_635.root -out SingleMuon_Run2016C_23Sep2016_v1_fix3_38.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016C_23Sep2016_v1_fix3_38.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016C_23Sep2016_v1_fix3/SingleMuon_Run2016C_23Sep2016_v1_fix3_38.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
