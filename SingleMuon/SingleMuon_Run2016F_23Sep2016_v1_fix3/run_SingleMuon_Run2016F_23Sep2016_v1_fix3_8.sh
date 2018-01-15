
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_207.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_208.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_209.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_21.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_210.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_211.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_212.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_213.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_214.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_215.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_216.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_217.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_218.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_219.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016F_23Sep2016_v1_fix3/170309_214710/0000/OutTree_22.root -out SingleMuon_Run2016F_23Sep2016_v1_fix3_8.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016F_23Sep2016_v1_fix3_8.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016F_23Sep2016_v1_fix3/SingleMuon_Run2016F_23Sep2016_v1_fix3_8.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
