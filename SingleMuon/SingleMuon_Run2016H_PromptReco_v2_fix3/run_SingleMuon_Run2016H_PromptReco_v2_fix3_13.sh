
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_309.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_31.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_310.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_311.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_312.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_313.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_314.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_315.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_316.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_317.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_318.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_319.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_32.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_320.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_321.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0000/OutTree_322.root -out SingleMuon_Run2016H_PromptReco_v2_fix3_13.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016H_PromptReco_v2_fix3_13.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016H_PromptReco_v2_fix3/SingleMuon_Run2016H_PromptReco_v2_fix3_13.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
