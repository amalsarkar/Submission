
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1565.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1566.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1567.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1568.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1569.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1570.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1571.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1572.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1573.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1574.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1575.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1576.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1577.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1578.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016D_23Sep2016_v1_fix3/170309_214612/0001/OutTree_1579.root -out SingleMuon_Run2016D_23Sep2016_v1_fix3_104.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016D_23Sep2016_v1_fix3_104.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016D_23Sep2016_v1_fix3/SingleMuon_Run2016D_23Sep2016_v1_fix3_104.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
