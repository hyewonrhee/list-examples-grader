CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area


git clone $1 student-submission
echo 'Finished cloning'
cd student-submission


if [[ -f ListExamples.java ]]
then 
    echo 'Found ListExamples.java'
else
    echo 'Need ListExamples.java'
    exit 1
fi

cd ..


cp student-submission/*.java *.java grading-area
cp -r lib grading-area
echo "grading-area contents:"
ls grading-area


javac -cp $CPATH grading-area/*.java 2> error-output.txt
if [ $? -ne 0 ]
then 
    echo 'Could not compile'
else
    echo 'Compiled successfully'
fi


cd grading-area
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
cat test-output.txt

if grep "OK" test-output.txt
then
    echo "PASSED ALL TESTS!"
else
    echo "YOU FAILED AT LEAST ONE TEST!"
fi
