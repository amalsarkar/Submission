
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1011.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1012.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1013.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1014.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1015.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1016.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1017.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1018.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1019.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1020.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1021.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1022.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1023.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1024.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0001/OutTree_1025.root -out SingleMuon_Run2016H_PromptReco_v2_fix3_58.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016H_PromptReco_v2_fix3_58.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016H_PromptReco_v2_fix3/SingleMuon_Run2016H_PromptReco_v2_fix3_58.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
