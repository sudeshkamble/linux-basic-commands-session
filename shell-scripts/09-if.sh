ls test 2> /dev/null
if [ $? -ne 0 ]
then
    echo error
fi    
