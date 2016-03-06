#!/bin/bash

header="M, optimisation, numNodes, SolverTime, SR time"
outputFile="results13"
echo "$header" >> "$outputFile"

for optimisation in `seq 0 3`;
do
	for m in `seq 1 11`;
	do
	echo "	running for size M=$m "
		data="$(./savilerow ../P1/part4.eprime -params "letting BOARD_SIZE = $m" -O${optimisation} -run-solver -solutions-to-stdout)"
		
		nodesE=${data##*SolverNodes: }
		nodes=${nodesE%%\$*}
		nodes="$(echo "${nodes//[$'\t\r\n ']}")"

		solverTimeE=${data##*SolverTotalTime: }
		solverTime=${solverTimeE%%\$*}
		solverTime="$(echo "${solverTime//[$'\t\r\n ']}")"


		srTimeE=${data##*Row TotalTime: }
		srTime=${srTimeE%%letting*}
		srTime="$(echo "${srTime//[$'\t\r\n ']}")"		

		result="${m}, ${optimisation}, ${nodes}, ${solverTime}, ${srTime}"

		echo "$result" >> "$outputFile"
	done
	echo "Optimisation level $optimisation is done"

done