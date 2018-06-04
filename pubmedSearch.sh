SHELL=/bin/bash/
filename='data/geneInf.txt'
echo "START PUBMED ANALYSIS"
mkdir "data/Genes/"
while read p; do
  var1=$(cut -d',' -f1 <<< $p)
  var1=$(cut -d"'" -f2 <<< $var1)
  name1="esearch.fcgi?db=pubmed&term=$var1"
  mkdir "data/Genes/$var1"
  cd "data/Genes/$var1"
  wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$var1"
  line1=$(sed '' $name1)

  #line1=$(cut -d'<IdList>' -f1 <<< $line1)

  var2=$(cut -d',' -f3 <<< $p)
  var2=$(cut -d"'" -f2 <<< $var2)
  name2="esearch.fcgi?db=pubmed&term=$var2"
  wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$var2"
  line2=$(sed '' $name2)

  #line2=$(cut -d'<IdList>' -f1 <<< $line2)

  var3=$(cut -d',' -f5 <<< $p)
  var3=$(cut -d"'" -f2 <<< $var3)
  name3="esearch.fcgi?db=pubmed&term=$var3"
  wget "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=$var3"
  line3=$(sed '' $name3)

  echo "$line1 $line2 $line3" >> $var1".txt"
  rm $name3
  rm $name2
  rm $name1
  #line3=$(cut -d'<IdList>' -f1 <<< $line3)
  cd ../../..
done <$filename