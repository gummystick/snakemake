#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 20 13:12:49 2018

@author: william
"""
import sys
from Bio import Entrez
import pickle

Entrez.email = "willysieswilly@gmail.com"

def main():  
    try:
        inFile = sys.argv[1]
        rightFormat = False
        genes = []
        with open(inFile) as file:
            for line in file:
                if line.startswith("GeneID"):
                    rightFormat = True
                genes.append(line.strip("\n"))
                
#        if rightFormat == False:
#            genes = convert(genes)
            #genesInfo = retrieveGenes(genes)
#        else:
        genesInfo = retrieveGenes(genes)
        writeRes(genesInfo, sys.argv[2])
    except IndexError as e:
        print("Input not provided")  
        
def retrieveGenes(genes):
    dicto = {}
    for gene in genes[0:10]:   
        handle = Entrez.efetch(db="gene", id=gene.split(":")[1], rettype="xml", retmode="text")
        record = Entrez.read(handle)
        #record = Entrez.read(handle)
        #for field in record["DbInfo"]["FieldList"]:
            #print("%(Name)s, %(FullName)s, %(Description)s" % field)
        #pids = record    
        try:
            func = record[0]["Entrezgene_locus"][0]["Gene-commentary_products"][0]["Gene-commentary_label"]
            prot = record[0]["Entrezgene_locus"][0]["Gene-commentary_products"][0]["Gene-commentary_accession"]
            pids = record[0]["Entrezgene_locus"][0]["Gene-commentary_products"][0]["Gene-commentary_refs"][0]["Pub_pmid"]
            seqID = record[0]["Entrezgene_gene-source"]["Gene-source"]["Gene-source_src-str1"]
            dicto[gene] = [gene, func, seqID, pids, prot]
        except KeyError as keyErr:
            print("No full gene info found for gene:",gene)
            pass
    print(dicto)
    handle.close()
    return dicto

def writeRes(geneInf, file):
    name = file.split(".")[0:len(file.split("."))-1]
    
    print("writing pickle for:",name)
    with open(''.join(name)+".pickle", 'wb') as openedFile:
#        openedFile.write(
        pickle.dump(geneInf, openedFile, protocol=pickle.HIGHEST_PROTOCOL)#)
        
    
#def retrievePubmed(genes):
#    dicto = {}
#    for gene in genes[0:10]:   
#        handle = Entrez.esearch(db="pubmed", term=gene.split(":")[1])
#        record = Entrez.read(handle)
#        pids = record["IdList"]
#        dicto[gene] = pids 
#        handle.close()
#    
#    print(dicto)

if __name__ == "__main__":
    main()


