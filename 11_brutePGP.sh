#!/bin/bash

fun_pgp () {
	gpg2 --batch -d --passphrase=$1 $pgpfile >outPGP$2 2>/dev/null
	len=$(wc -l outPGP$2 | cut -f 1 -d " ")
	if [ $len != 0 ]
		then
		ENDTIME=$(date +%s)
		kill $pid
		echo -e "${PURPLE}Time elapsed: $((ENDTIME-$STARTTIME))s - $2/$total ($((100*$2/total))%)${NC}"
		echo -e "${YELL}[+] Password Found: $1${NC}"
		echo -e "${YELL}[+] Output File: outPGP$2${NC}"
		echo ""
		exit
	fi
	rm outPGP$2

}
command -v gpg2 >/dev/null 2>&1 || { echo >&2 "[-] gpg2 is required and it's not installed.  Aborting."; exit 1; }
numPar="$#"
if [ $numPar != 2 ]
then
	echo "Error"
	echo "Usage: $0 file.pgp wordlist"
	exit
fi

if [ ! -f $1 ]
then
	echo "Pgp File ( $1 ) does not exit"
	exit
fi

if [ ! -f $2 ]
then
	echo "Wordlist ( $2 ) does not exit"
	exit
fi
STARTTIME=$(date +%s)
GREEN='\e[1;32m'
RED='\e[0;31m'
BLUE='\e[0;34m'
YELL='\e[1;33m'
PURPLE='\e[1;35m'
NC='\e[0m' # No Color

echo -e "${GREEN}
 _______  _______  _______  _______  _        _______  _______  _______ 
(  ____ \(  ____ )(  ___  )(  ____ \| \    /\(  ____ )(  ____ \(  ____ )
| (    \/| (    )|| (   ) || (    \/|  \  / /| (    )|| (    \/| (    )|
| |      | (____)|| (___) || |      |  (_/ / | (____)|| |      | (____)|
| |      |     __)|  ___  || |      |   _ (  |  _____)| | ____ |  _____)
| |      | (\ (   | (   ) || |      |  ( \ \ | (      | | \_  )| (      
| (____/\| ) \ \__| )   ( || (____/\|  /  \ \| )      | (___) || )      
(_______/|/   \__/|/     \|(_______/|_/    \/|/       (_______)|/       
                                                                        
                                                                       ${RED}by @manulqwerty 
                                                                       
${BLUE}--------------------------------------------------------------------------------${NC}
"
total=$(wc -l $2 | cut -f 1 -d " ")
pgpfile=$1
i=1
pid=$$
while IFS='' read -r line || [[ -n "$line" ]]; do
    fun_pgp $line $i &
	x=$((100*i/total))
    echo -n -e "${PURPLE}[*] $line - $i/$total ($x%)${NC}" $'\r'
    i=$((i +1))       
    sleep 0.05
done < $2
