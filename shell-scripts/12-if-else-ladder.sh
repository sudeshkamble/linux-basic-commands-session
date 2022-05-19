echo -n "Enter your age:"
read var

if [ $var -ge 18 ]
then
    echo "Have you applied for a Driver's License?" 
elif test $var -ge 12
then
    echo "You are too young to apply for a DL"
elif test $var -ge 0
then
    echo "How did you reach here?"
else
    echo "Invalid Age"
fi