PROCESS[1]="SAMPLES_LIST_DATA_SingleMuonB"
PROCESS[2]="SAMPLES_LIST_DATA_SingleMuonC"
PROCESS[3]="SAMPLES_LIST_DATA_SingleMuonD"
PROCESS[4]="SAMPLES_LIST_DATA_SingleMuonE"
PROCESS[5]="SAMPLES_LIST_DATA_SingleMuonF"
PROCESS[6]="SAMPLES_LIST_DATA_SingleMuonG"
PROCESS[7]="SAMPLES_LIST_DATA_SingleMuonH"

FOLDER[1]="SingleMuonB"
FOLDER[2]="SingleMuonC"
FOLDER[3]="SingleMuonD"
FOLDER[4]="SingleMuonE"
FOLDER[5]="SingleMuonF"
FOLDER[6]="SingleMuonG"
FOLDER[7]="SingleMuonH"

for i in `seq 1 7` ; 
do
echo Running ${PROCESS[$i]}
./remote.py ${PROCESS[$i]}.cfg -t ${FOLDER[$i]} --force
done

