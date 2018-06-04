#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May 26 12:47:08 2018

@author: william
"""

import os
import sys
from Bio import Entrez
import pickle

Entrez.email = "willysieswilly@gmail.com"

def main():  
    newDict = {}
    with open(sys.argv[1], "rb") as handle:
        content = pickle.load(handle)
    for gene in content.keys():
        newDict[gene] = getSeq(content[gene])
    
    print("Writing pickle")
    with open(sys.argv[2], "wb") as handle2:
        pickle.dump(newDict, handle2,  protocol=pickle.HIGHEST_PROTOCOL)
    print("Done writing")
    
    print("Writing info")
    with open("data/geneInf.txt", "w") as openFile:
        keys = newDict.keys()
        for key in keys:
            info = newDict[key]
            openFile.write(str(info)+"\n")
    print('Done writing')
    writeFasta(newDict)
    
def getSeq(geneContent):
#    try:
    handle = Entrez.efetch(db="protein", id=geneContent[4], rettype="fasta", retmode="text")
    record = handle.read()
    geneContent.append('\n'.join(record.split("\n")[1:]))
    handle.close()
    
    return geneContent
#    except:
#        print("error")
#        pass

def writeFasta(dict):
    directory = "data/sequences"
    try:
        os.stat(directory)
    except:
        os.mkdir(directory)       
    with open("data/sequences/sequences.fasta", "w") as seqFile:
        for i in dict.keys():
            print(">"+i+"\n"+dict[i][5])
            seqFile.write(">"+i+"\n"+dict[i][5]+"\n")
    return
if __name__ == "__main__":
    main()

