#!/bin/bash

header="M, optimisation, numNodes, SolverTime, SR time"
outputFile="newOutput"
echo "$header" >> "$outputFile"

for m in `seq 1 12`;
do
	echo "running for size M=$m "
	for optimisation in `seq 0 3`;
	do
		data="$(./savilerow ../P1/part1.eprime -params "letting BOARD_SIZE = $m" -O${optimisation} -run-solver -solutions-to-stdout)"
		
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

		echo "	optimisation level $optimisation is done"
	done
done