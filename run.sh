#!/bin/bash
#############################################################
####         DATA
#############################################################
##MET
DATA_CFG[0]="SAMPLES_LIST_DATA_MET"
DATA_CFG[1]="SAMPLES_LIST_DATA_TAU"
DATA_CFG[2]="SAMPLES_LIST_DATA_SingleMuon"
##TAU
DATA_FOLDER[0]="MET"
DATA_FOLDER[1]="TAU"
DATA_FOLDER[2]="SingleMuon"
#SINGLE
DATA_SINGLE_CFG[0]="SAMPLES_LIST_DATA_SingleMuonB"
DATA_SINGLE_CFG[1]="SAMPLES_LIST_DATA_SingleMuonC"
DATA_SINGLE_CFG[2]="SAMPLES_LIST_DATA_SingleMuonD"
DATA_SINGLE_CFG[3]="SAMPLES_LIST_DATA_SingleMuonE"
DATA_SINGLE_CFG[4]="SAMPLES_LIST_DATA_SingleMuonF"
DATA_SINGLE_CFG[5]="SAMPLES_LIST_DATA_SingleMuonG"
DATA_SINGLE_CFG[6]="SAMPLES_LIST_DATA_SingleMuonH"
#########################################
DATA_SINGLE_FOLDER[0]="SingleMuonB"
DATA_SINGLE_FOLDER[1]="SingleMuonC"
DATA_SINGLE_FOLDER[2]="SingleMuonD"
DATA_SINGLE_FOLDER[3]="SingleMuonE"
DATA_SINGLE_FOLDER[4]="SingleMuonF"
DATA_SINGLE_FOLDER[5]="SingleMuonG"
DATA_SINGLE_FOLDER[6]="SingleMuonH"
############################################################
####          MC
###########################################################
MC_CFG[0]="SAMPLES_LIST_MC_All"
MC_CFG[1]="SAMPLES_LIST_MC_All_QCD"
MC_CFG[2]="SAMPLES_LIST_MC_DYJets"
MC_CFG[3]="SAMPLES_LIST_MC_TT"
MC_CFG[4]="SAMPLES_LIST_MC_ST"
MC_CFG[5]="SAMPLES_LIST_MC_VV"
MC_CFG[6]="SAMPLES_LIST_MC_WJets"
#########################################
MC_FOLDER[0]="AllMC"
MC_FOLDER[1]="AllMC_QCD"
MC_FOLDER[2]="DYJets"
MC_FOLDER[3]="TT"
MC_FOLDER[4]="ST"
MC_FOLDER[5]="VV"
MC_FOLDER[6]="WJets"
############################################################
#### 	    SIGNAL
###########################################################
SIGNAL_CFG[0]="SAMPLES_LIST_SIGNAL_STAU"
SIGNAL_FOLDER[0]="SIGNAL_STAU"


###################### Parameters
EXE="remote.py"
FINAL="TEMP"

echo "Please enter Data (0), MC (1) or Signal (2)"
read type_d

if [ "$type_d" -eq 0 ]; then
echo Please Choose the sample: 
for i in `seq 0 2` ;
do
echo $i for: ${DATA_FOLDER[$i]}
done

echo ------------------------
read idata

	if [ "$idata" -eq 2 ]; then
	for j in `seq 0 6` ;
	do
	echo Running ${DATA_SINGLE_CFG[$j]} to $FINAL/${DATA_SINGLE_FOLDER[$j]}
	./$EXE ${DATA_SINGLE_CFG[$j]}.cfg -t $FINAL/${DATA_SINGLE_FOLDER[$j]} --force
	done

	else
	echo Running ${DATA_CFG[$idata]} to $FINAL/${DATA_FOLDER[$idata]}
	./$EXE ${DATA_CFG[$idata]}.cfg -t $FINAL/${DATA_FOLDER[$idata]} --force
	fi	


elif [ "$type_d" -eq 1 ]; then
echo Please Choose the MC sample: 
for j in `seq 0 6` ;
do
echo $j for: ${MC_FOLDER[$j]}
done
echo ------------------------
read imc
echo Running ${MC_CFG[$imc]} to $FINAL/${MC_FOLDER[$imc]}
./$EXE ${MC_CFG[$imc]}.cfg -t $FINAL/${MC_FOLDER[$imc]} --force

        	

elif [ "$type_d" -eq 2 ]; then        
echo Running ${SIGNAL_CFG[0]} to $FINAL/${SIGNAL_FOLDER[0]}
./$EXE ${SIGNAL_CFG[0]}.cfg -t $FINAL/${SIGNAL_FOLDER[0]} --force

else
echo No valid option
			
		
fi
