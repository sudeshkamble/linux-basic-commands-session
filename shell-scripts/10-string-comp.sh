expected=left
actual=right
dirright=right
dirleft=left

if [ expected == actual ]
then
    echo equal
fi

if [ $expected == $dirleft ]
then
    echo equal
fi