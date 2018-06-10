#DATA
DATAFILECFG[0]="SAMPLES_LIST_DATA_MET.cfg"
DATAFILECFG[1]="SAMPLES_LIST_DATA_SingleMuon.cfg"
DATAFILECFG[2]="SAMPLES_LIST_DATA_TAU.cfg"
#########################################
DATAFOLDER[0]="MET"
DATAFOLDER[1]="SingleMuon"
DATAFOLDER[2]="TAU"
#MC
MCFILECFG[0]="SAMPLES_LIST_MC_All.cfg"
MCFILECFG[1]="SAMPLES_LIST_MC_DYJets.cfg"
MCFILECFG[2]="SAMPLES_LIST_MC_TT.cfg"
MCFILECFG[3]="SAMPLES_LIST_MC_VV.cfg"
MCFILECFG[4]="SAMPLES_LIST_MC_WJets.cfg"
#########################################
MCFOLDER[0]="AllMC"
MCFOLDER[1]="DYJets"
MCFOLDER[2]="TT"
MCFOLDER[3]="VV"
MCFOLDER[4]="WJets"

###
EXE="remote.py"

echo "Please enter Data (0) or MC (1)"
read type_d

if [ "$type_d" -eq 0 ]; then
echo Please Choose the sample: 
for j in `seq 0 2` ;
do
echo $j for: ${DATAFOLDER[$j]}
done
echo ------------------------
read index
echo running ----- ${DATAFILECFG[$index]} ----- to folder ----- ${DATAFOLDER[$index]}
./$EXE ${DATAFILECFG[$index]} -t ${DATAFOLDER[$index]} --force
else
	if [ "$type_d" -eq 1 ]; then
	echo Please Choose the sample: 
	for j in `seq 0 4` ;
	do
	echo $j for: ${MCFOLDER[$j]}
	done
	echo ------------------------
	read index
	echo running ----- ${MCFILECFG[$index]} ----- to folder ----- ${MCFOLDER[$index]}
	./$EXE ${MCFILECFG[$index]} -t ${MCFOLDER[$index]} --force 
	else
	echo no valid option
	fi
fi
