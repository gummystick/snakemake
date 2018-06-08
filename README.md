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
    SAPP (Conversion, interProScan and HDTQuery versions uploaded on 2018-06-03 06:44)


Preparations

To download the project files via the terminal use the following command: 

    git clone "https://github.com/gummystick/snakemake.git"

Conda environment

    Create Conda env
    conda env create  --name eindOpdracht --file environment.yaml

    Change env
    source activate eindOpdracht

R

    Install R
    apt update
    apt -y install r-base

SAPP

    Download the Conversion.jar, interProScan.jar, and HDTQuery.jar files from: http://download.systemsbiology.nl/sapp/
    and place them in a SAPP directory in the downloaded git repository.(must be in "snakemake" directory)  
    First execution of SAPP will take a little while, because the required dependencies are downloaded. For more info on SAPP
    see: https://sapp.gitlab.io/
    
Usage of the workflow:

    After installation of all requirements go to the "snakemake" folder in the git repository.
    And execute the snakefile in this directory with the command: snakemake


Output

After running the script several folders are created. In the "output" directory an report.html can be found. This contains the links to the most fital results. All results are stored in "data" and "output".

Refs:
- SAPP: functional genome annotation and analysis through a semantic framework using FAIR principles
Koehorst, Jasper J. and van Dam, Jesse C.J. and Saccenti, Edoardo and Martins dos Santos, Vitor A.P. and Suarez-Diez, Maria and Schaap, Peter J.

- Philip Jones, David Binns, Hsin-Yu Chang, Matthew Fraser, Weizhong Li, Craig McAnulla, Hamish McWilliam, John Maslen, Alex Mitchell, Gift Nuka, Sebastien Pesseat, Antony F. Quinn, Amaia Sangrador-Vegas, Maxim Scheremetjew, Siew-Yit Yong, Rodrigo Lopez, and Sarah Hunter (2014). InterProScan 5: genome-scale protein function classification. Bioinformatics, Jan 2014; doi:10.1093/bioinformatics/btu031

- Köster, Johannes and Rahmann, Sven. “Snakemake - A scalable bioinformatics workflow engine”. Bioinformatics 2012.

- Cock PA, Antao T, Chang JT, Chapman BA, Cox CJ, Dalke A, Friedberg I, Hamelryck T, Kauff F, Wilczynski B and de Hoon MJL (2009) Biopython: freely available Python tools for computational molecular biology and bioinformatics. Bioinformatics, 25, 1422-1423
