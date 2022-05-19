echo -n "Enter your grade"
read var

var=$(echo $var | tr '[:lower:]' '[:upper:]')

case $var in
    A) 
        echo "Excellent Work - $var";;
    B|C) 
        echo "Well done - $var";;
    D)
        echo "You survived - $var";;
    F)
        echo "Better try again - $var";;
    *) 
        echo "Invalid grade - $var";;
esac