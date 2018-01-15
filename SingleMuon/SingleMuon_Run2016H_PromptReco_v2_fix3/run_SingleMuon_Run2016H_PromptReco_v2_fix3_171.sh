
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2736.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2737.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2738.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2739.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2740.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2741.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2742.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2743.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2744.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2745.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2746.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2747.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2748.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2749.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2750.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2751.root -out SingleMuon_Run2016H_PromptReco_v2_fix3_171.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016H_PromptReco_v2_fix3_171.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016H_PromptReco_v2_fix3/SingleMuon_Run2016H_PromptReco_v2_fix3_171.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
