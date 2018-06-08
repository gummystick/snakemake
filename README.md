# Snakemake

Authors:

    William Sies

Contact:

    w.j.sies@student.han.nl

Description

An automated workflow for gaining more information on gene-identifiers.

Requirements System

    Linux operating system. The software is developed on Linux Ubuntu 16.04
    WARNING: Difficulties can arise, when another version of opperating system is used.

Dependencies

    Python 3.5.1
    Conda 4.5.4
    Snakemake 3.11.0
    Biopython 1.69
    R version 3.4.4 (2018-03-15) -- "Someone to Lean On"
    openjdk version "1.8.0_112"
    OpenJDK Runtime Environment (Zulu 8.19.0.1-linux64) (build 1.8.0_112-b16)
    OpenJDK 64-Bit Server VM (Zulu 8.19.0.1-linux64) (build 25.112-b16, mixed mode)


Preparations

To download the project files via the terminal use the following command: git clone "https://github.com/gummystick/snakemake.git"

Conda environment

    Create Conda env
    conda env create  --name eindOpdracht --file environment.yaml

    Change env
    source activate eindOpdracht

R
    Install R
    apt update
    apt -y install r-base

Usage of the workflow:

    After installation of all requirements go to the "snakemake" folder in the git repository.
    And execute the snakefile in this directory with the command: snakemake


Output

After running the script several folders are created. In the "output" directory an report.html can be found. This contains the links to the most fital results. All results are stored in "data" and "output".
