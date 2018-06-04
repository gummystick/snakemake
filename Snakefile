import os
import glob

INFILE = 'data/genes.txt'
OUTFLOW = ['output/readAndConvert.pickle', 'output/sequences.pickle', "data/sequences/sequences.fasta", "data/rdf/sequences.hdt", "data/interProData.txt"]
rightFormat = False

rule all:
	input:
		"output/report.html",
		# "output/dag.svg"

rule readAndConvert:
	input:
		{INFILE}
	output:
		{OUTFLOW[0]}
	shell:
		'python genes.py {INFILE} {output}'
		# with open({input}) as file:
		# 	for line in file:
		# 		if line.startswith("GeneID"):
	 #                rightFormat = True
	 #                genes = genes + line
  #               	print(line)

rule getSequences:
	input:
		{OUTFLOW[0]}
	output:
		{OUTFLOW[1]},
		{OUTFLOW[2]}
	shell:
		'python sequences.py {input} {output}'

rule prepareSAPP:
	input:
		{OUTFLOW[2]}
	output:
		{OUTFLOW[3]}
	shell:
		'mkdir data/rdf | java -jar SAPP/Conversion.jar -fasta2rdf -protein -id sequencesIPR -i {input} -o {output} -gene'

rule interProScan:
	input:
		{OUTFLOW[3]}
	output:
		{OUTFLOW[4]}
	shell:
		'./shellRestIPR.sh'

rule dag:
   output:
       "output/dag.svg"
   shell:
   	'snakemake --forceall --dag | dot -Tsvg {output}'


rule report:
	input:
		{OUTFLOW[4]}
	output:
		"output/report.html"
	run:
		import pickle
		from snakemake.utils import report

		with open(input[0], "r") as handle:
		     content = handle.readlines()

		report("""
		An example variant calling workflow
		===================================

		The resulted line {content}.
		""", output[0], T1=input[0])
