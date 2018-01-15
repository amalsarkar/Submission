
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2371.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2372.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2373.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2374.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2375.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2376.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2377.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2378.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2379.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2380.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2381.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2382.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2383.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2384.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2385.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2386.root -out SingleMuon_Run2016H_PromptReco_v2_fix3_147.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016H_PromptReco_v2_fix3_147.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016H_PromptReco_v2_fix3/SingleMuon_Run2016H_PromptReco_v2_fix3_147.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
