for i in {1..10}
do
    echo $i>>test$i.txt
done

ls

for((i=1;i<=10;i++))
do
    cat test$i.txt
done

for file in $(ls)
do
    echo $file
    rm $file
done

ls