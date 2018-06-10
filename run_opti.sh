#MC
MCFILECFG[0]="SAMPLES_LIST_MC_DYJets.cfg"
MCFILECFG[1]="SAMPLES_LIST_MC_WJets.cfg"
#########################################
MCFOLDER[0]="DYJets"
MCFOLDER[1]="WJets"
########################################
SIGNALCFG[0]="SAMPLES_LIST_STAU.cfg"
#######################################
SIGNALFOLDER[0]="STAU"

###
EXE="remote.py"

echo "Running optimization"
./$EXE ${SIGNALCFG[0]} -t ${SIGNALFOLDER[0]} --force 

for j in `seq 0 1` ;
do
echo running ----- ${MCFILECFG[$j]} ----- to folder ----- ${MCFOLDER[$j]}
./$EXE ${MCFILECFG[$j]} -t ${MCFOLDER[$j]} --force
done
