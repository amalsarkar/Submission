
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_691.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_692.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_693.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_694.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_695.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_696.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_697.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_698.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_699.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_7.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_70.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_700.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_701.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_702.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016C_23Sep2016_v1_fix3/170309_214548/0000/OutTree_703.root -out SingleMuon_Run2016C_23Sep2016_v1_fix3_43.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016C_23Sep2016_v1_fix3_43.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016C_23Sep2016_v1_fix3/SingleMuon_Run2016C_23Sep2016_v1_fix3_43.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
