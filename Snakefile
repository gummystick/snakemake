import os
import glob

INFILE = 'data/genes.txt'
OUTFLOW = ['output/readAndConvert.pickle', 'output/sequences.pickle']
rightFormat = False

rule all:
	input:
		"output/report.html",
#		"output/dag.svg"

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
		{OUTFLOW[1]}
	shell:
		'python sequences.py {input} {output}'

#rule dag:
#    output:
#        "output/dag.svg"
#    shell:
#    	'snakemake --forceall --dag | dot -Tsvg {output}'
rule report:
	input:
		{OUTFLOW[1]}
	output:
		"output/report.html"
	run:
		import pickle
		from snakemake.utils import report

		with open(input[0], "rb") as handle:
		    content = pickle.load(handle)

		report("""
		An example variant calling workflow
		===================================

		The resulted line {content}.
		""", output[0], T1=input[0])
