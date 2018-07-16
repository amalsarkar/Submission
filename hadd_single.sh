eos_folder="/eos/uscms/store/user/msegura"
single_folder="RESULT/SingleMUON"

FOLDER[0]="SingleMuonB"
FOLDER[1]="SingleMuonC"
FOLDER[2]="SingleMuonD"
FOLDER[3]="SingleMuonE"
FOLDER[4]="SingleMuonF"
FOLDER[5]="SingleMuonG"
FOLDER[6]="SingleMuonH"

mkdir -p $single_folder

for i in `seq 0 6` ;
do
echo Running ${FOLDER[$i]}
hadd -f $single_folder/${FOLDER[$i]}.root $eos_folder/${FOLDER[$i]}/*/*.root & 
done

wait
echo Ending allData.root file
hadd $single_folder/allData.root $single_folder/*.root
