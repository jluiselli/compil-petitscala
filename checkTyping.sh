#!/bin/bash

score=0
scorePos=0
scoreNeg=0
max=0
maxPos=0
maxNeg=0

prgmFail=0

echo "Tests positifs (fichiers dans tests/good/)"

for f in tests/syntax/good/*.scala tests/typing/good/*.scala tests/exec/*.scala tests/exec-fail/*.scala; do
    maxPos=`expr $maxPos + 1`;
    echo $f
    rm -f out
    ./pscala $f > out
	case $? in
		0) scorePos=`expr $scorePos + 1` ;;
		1) echo "  ECHEC du parsing pour $f" ;;
		2) prgmFail=`expr $prgmFail + 1`;echo "  ECHEC du programme pour $f" ;;
    esac
done
echo

echo "Tests négatifs (fichiers dans tests/bad/)"

for f in tests/syntax/bad/*.scala tests/typing/bad/*.scala; do
    maxNeg=`expr $maxNeg + 1`;
    echo $f
    rm -f out
	./pscala $f > out 2>&1
	
	case $? in
		0) echo "  ECHEC : le parsing de $f devrait échouer" ;;
   		1) scoreNeg=`expr $scoreNeg + 1` ;;
		2) prgmFail=`expr $prgmFail + 1`;echo "  ECHEC du programme pour $f" ;;
    esac
done

rm out

echo
max=`expr $maxPos + $maxNeg`
score=`expr $scorePos + $scoreNeg`
percent=`expr 100 \* $score / $max`;
echo "Score: $score / $max tests, soit $percent%"
echo "Dont $scorePos / $maxPos positifs, $scoreNeg / $maxNeg négatifs"
echo "Dont `expr $max - $prgmFail - $score` / $max mauvais résultats"
echo "Dont $prgmFail / $max échecs du programme (exit 2)"
