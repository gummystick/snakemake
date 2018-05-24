import os
import glob

genes = []
rightFormat = False

input = "data/genes.txt"

# rule all:
# 	input:
# 		"report.html"

rule readAndConvert:
	run:
		print({input})
		with open('data/genes.txt') as file:
			for line in file:
				if line.startswith("GeneID"):
	                rightFormat = True

            
	# input:
	# 	{input}

#rule dag:
	# output:
		# 'model/dag.svg'
	# shell:
		# 'snakemake --forecall --dag| dot -Tsvg > {output}'

# rule report:
# 	input:
# 		"data/Hello.txt"
# 	output:
# 		"output/report.html"
# 	run:
# 		from snakemake.utils import report
# 		with open(input[0]) as txt:
# 		    content = txt.readlines()
# 		report("""
# 		An example variant calling workflow
# 		===================================

# 		The resulted line {genes}.
# 		""", output[0], T1=input[0])
