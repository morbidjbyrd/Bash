#!/bin/bash

domain=aaaaaaa.com
company=aaaaaaa

cd /home/kali/osint/scans/aaaaaaa/$company

touch $company.gobuster.old.txt
touch $company.amass.old.txt

gobuster dns -d $domain -w /usr/share/wordlists/amass/subdomains-top1mil-110000.txt --wildcard >> /home/kali/osint/scans/prosperitylife/$company/$company.gobuster.txt & go_pid=$!
wait $gobuster_pid

sleep 5



sort -u $company.gobuster.txt -o $company.gobuster.txt && sort -u $company.gobuster.old.txt -o $company.gobuster.old.txt && diff $company.gobuster.txt $company.gobuster.old.txt | cut -c 3- > $company.gobuster.new.txt

cp $company.gobuster.txt $company.gobuster.old.txt




amass enum -active -d $domain -tr 8.8.8.8,1.1.1.1 -brute -w /usr/share/amass/wordlists/deepmagic.com_top500prefixes.txt >> /home/kali/osint/scans/prosperitylife/$company/$company.amass.txt & amass_pid=$!
wait $amass_pid

sort -u $company.amass.txt -o $company.amass.txt && sort -u $company.amass.old.txt -o $company.amass.old.txt && diff $company.amass.txt $company.amass.old.txt | cut -c 3- > $company.amass.new.txt

cp $company.amass.txt $company.amass.old.txt
