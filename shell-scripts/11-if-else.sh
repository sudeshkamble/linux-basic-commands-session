echo "Enter your age:"
read var
echo $var

if [ $var -ge 18 ]
then
   echo "Have you applied for a Driver's License?" 
else
    diff=$((18-$var))
    echo "$diff year(s) for your license"
fi