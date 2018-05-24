#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 20 13:12:49 2018

@author: william
"""
import sys

def main():     
    rightFormat = False
    genes = []
    with open(file) as file:
        for line in file:
            if line.startswith("GeneID"):
                rightFormat = True
            genes = genes + line
            
    print(genes)
    if rightFormat == False:
        convert(genes)

def convert(genes):
    for gene in genes:
        print(gene)

if __name__ == "__main__":
    main()


