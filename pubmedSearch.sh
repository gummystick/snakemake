SHELL=/bin/bash/
filename='data/geneInf.txt'
echo "START PUBMED ANALYSIS"
while read p; do
  echo wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$p"
done <$filename