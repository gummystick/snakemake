import os
import glob

INFILE = 'data/genes.txt'
OUTFLOW = ['output/readAndConvert.pickle', 'output/sequences.pickle', "data/geneInf.txt", "data/sequences/sequences.fasta", "data/rdf/sequences.hdt", "data/interProData.txt", "data/RInput1.txt", "data/RInput2.txt", "output/GC.pdf"]
rightFormat = False

rule all:
	input:
		"output/report.html",
		# "output/dag.svg"

rule readAndConvert:
	input:
		{INFILE}
	output:
		{OUTFLOW[0]},

	shell:
		'python genes.py {INFILE} {output}'

rule getSequences:
	input:
		{OUTFLOW[0]}
	output:
		{OUTFLOW[1]},
		{OUTFLOW[2]},
		{OUTFLOW[3]}
	shell:
		'python sequences.py {input} {output[0]}'

rule prepareSAPP:
	input:
		{OUTFLOW[3]}
	output:
		{OUTFLOW[4]}
	shell:
		'mkdir data/rdf | java -jar SAPP/Conversion.jar -fasta2rdf -protein -id sequencesIPR -i {input} -o {output} -gene'

rule interProScan:
	input:
		{OUTFLOW[3]},
		{OUTFLOW[4]}
	output:
		{OUTFLOW[5]}
	shell:
		'./shellRestIPR.sh'

rule reformResults:
	input:
		{OUTFLOW[5]},
		{OUTFLOW[2]}
	output:
		{OUTFLOW[6]},
		{OUTFLOW[7]},
		{OUTFLOW[8]}
	run:
		import subprocess
		with open(input[0], 'r') as iprFile:
			with open(output[0], 'w') as writeFile:
				for line in iprFile:
					if (line.startswith("G") or line.startswith("geneId")):
						writeFile.write(line)
					
		with open(input[1], 'r') as geneInfFile:
			with open(output[1], 'w') as writeFile:
				for line in geneInfFile:
					newline = "".join(line[1:len(line)-2]).replace("'", "")
					writeFile.write(newline+"\n")

		command = "Rscript interPro.R"+" "+ output[0]+" "+output[1]+" "+output[2]
		process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
		output, error = process.communicate()
		if (error != None):
			raise Exception("Something went wrong while executing: "+command+"\nerror: "+error)

rule dag:
   output:
       "output/dag.svg"
   shell:
   	'snakemake --forceall --dag | dot -Tsvg {output}'


rule report:
	input:
		{OUTFLOW[3]},
		{OUTFLOW[6]},
		{OUTFLOW[7]},
		{OUTFLOW[8]}
	output:
		"output/report.html"
	run:
		import pickle
		from snakemake.utils import report

		report("""
		Analysis results of the given genes.
		===================================

		List of outputfiles: 
		""", output[0], T1=input[0], T2=input[1], T3=input[2], T4=input[3])
