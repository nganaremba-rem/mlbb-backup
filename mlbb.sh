clear
red="\e[1;91m"
green="\e[1;92m"
def="\e[0m"
hlight="\e[1;101m"

check(){
	[ $(echo $?) -eq 0 ] && (echo -e " $1 -->${green} OK ${def}";flag=1;) || (echo -e "$1 --> ${red} ERROR ${def}";flag=0);
}


echo -e "${hlight} Rem Mobile Legends Backup & Restore ${def}\n"
echo -ne "${green}1. Zip com.mobile.legends\n2. Unzip com.mobile.legends\n\n${def}Choose 1/2: "
read choice
case $choice in
1) 	touch /sdcard/Android/data/test > /dev/null 2>&1
	check "Android/data Permission"
	[[ $flag -eq 1 ]] && { rm /sdcard/Android/data/test; } || { echo -e "Please run the command termux-setup-storage";flag=0; }
	[[ $flag -ne 0 ]] && {
######################   if Android/data accessible ##############
	yes | pkg install p7zip
	7z a /sdcard/mlbb.zip /sdcard/Android/data/com.mobile.legends
	check "Backup Processing";
	} || { exit; }
	;;

2)	[[ -e "/sdcard/mlbb.zip" ]]
	check "Backup file Status"
	[[ $flag -ne 1 ]] && { echo -e "${red}Backup File Not Present ${def}"; exit; }
	yes | pkg install p7zip
	7z x /sdcard/mlbb.zip -o/sdcard/Android/data/
	check "Extracting Mobile Legends Data"
	;;

*)	echo -e "${red}Please enter a valid input${def}"
	;;
esac


