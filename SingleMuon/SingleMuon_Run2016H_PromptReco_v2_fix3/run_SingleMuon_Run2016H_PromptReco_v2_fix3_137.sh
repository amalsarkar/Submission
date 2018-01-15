
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

./Analyzer -in root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2219.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2220.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2221.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2222.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2223.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2224.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2225.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2226.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2227.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2228.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2229.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2230.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2231.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2232.root root://cmseos.fnal.gov///store/user/ra2tau/jan2017tuple/SingleMuon/SingleMuon_Run2016H_PromptReco_v2_fix3/170309_214813/0002/OutTree_2233.root -out SingleMuon_Run2016H_PromptReco_v2_fix3_137.root -C PartDet 

xrdcp -sf $_CONDOR_SCRATCH_DIR/SingleMuon_Run2016H_PromptReco_v2_fix3_137.root root://cmseos.fnal.gov//store/user/msegura/SingleMuon//SingleMuon_Run2016H_PromptReco_v2_fix3/SingleMuon_Run2016H_PromptReco_v2_fix3_137.root
rm run.sh
rm -r Analyzer 
rm -r Pileup 
rm -r PartDet 
rm -r *.root 
rm -r *.tar.gz 
