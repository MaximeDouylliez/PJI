FilePath=$1

 #Récupération du nombre de ligne du fichier
I=`cat $FilePath | wc -l`

#itération sur chaque ligne et modification des valeurs négatives rencontrées
for j in `seq 1 $I`; do
    ChargeValue=`head -n $j $FilePath | tail -n 1 |cut -d ' ' -f 2`

#Si la première lettre de ChargeValue est un '-'
  if [ "-" = ${ChargeValue::1} ]

then
#le début de ligne est restitué tel quel, la valeur de charge est modifié à 0
   TimeIndicator=`head -n $j $FilePath | tail -n 1 |cut -d ' ' -f 1`
  echo "`sed $j'c\'$TimeIndicator' 0.0 ' $FilePath`" >$FilePath
fi
done


