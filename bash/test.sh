#!/usr/bin/env bash
set -e
touch ./ptf-report.txt
if [ -d ptf_logs ]
then
    list=$(ls ./ptf_logs/xunit/xunit/|grep .xml)	
    for i in $list
    do
            STATUS=$(cat ./ptf_logs/xunit/xunit/$i |grep failures|awk '{print $3}'|cut -d '=' -f2| tr -d '"')
            if [[ $STATUS -eq "0" ]]
            then
                    echo "$i PASSED" >> ./ptf-report.txt
            else
                    echo "$i FAILED" >> ./ptf-report.txt
            fi
    done
else
    echo "bash: ./ptf_logs No such file or directory"
fi
ALL_TESTS=$(cat ./ptf-report.txt|wc -l)
PASSED_TESTS=$(cat ./ptf-report.txt|grep PASSED|wc -l)
if [[ $ALL_TESTS -ne 0 ]]
then
	a=$(echo "scale=1; 100*($PASSED_TESTS/$ALL_TESTS)"|bc)
	b=$(echo ${a%.*})
	COVERAGE=$b
else
    COVERAGE=0
fi
echo "$PASSED_TESTS/$ALL_TESTS $COVERAGE%" >> ./ptf-report.txt
