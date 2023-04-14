# AWK   

### Basic awk command  
```awk
awk -F: '{print $1, $NF}' /etc/passwd
```
| Symbol | Description |
|-----|-----|
| -F: | Colon as a separator |
| {...} | Awk program |
| print | Prints the current record |
| $1 | First field |
| $NF | Last field |
| /etc/passwd | Input data file |


> Installation : `sudo apt-get install awk` is required to use awk

### AWK program pattern
```
BEGIN          {<initializations>} 
   <pattern 1> {<program actions>} 
   <pattern 2> {<program actions>} 
   ...
END            {< final actions >}
```
#### Example
```awk
awk -F: '
    BEGIN { print "\n>>>Start" }
    { print NR, $1, $0 }
    END { print "<<<END\n" }
' /etc/passwd
```

### AWK variables
```awk
# First and last field
awk -F: '{print $1,$NF}' /etc/passwd

# With line number
awk -F: '{print NR, $0}' /etc/passwd

# Second last field
awk -F: '{print $(NF-1)}' /etc/passwd

# Custom string 
awk -F: '{print $1 "=" $6}' /etc/passwd
```

| Variable | Description |
|----|----|
| $0 | Whole line |
| $1, $2...$NF | 	First, second… last field |
| NR | Number of Records |
|NF | Number of Fields |
|OFS|	Output Field Separator (default " ")
|FS |	input Field Separator (default " ")
|ORS|Output Record Separator(default "\n")
|RS|input Record Separator(default "\n")
|FILENAME|Name of the file

### AWK blocks
```awk
awk 'BEGIN {print "hello world"}'        # Prints "hello world"
awk -F: '{print $1}' /etc/passwd         # -F: Specify field separator

# /pattern/ Execute actions only for matched pattern
awk -F: '/root/ {print $1}' /etc/passwd                     

# BEGIN block is executed once at the start
awk -F: 'BEGIN { print "uid"} { print $1 }' /etc/passwd     

# END block is executed once at the end
awk -F: '{print $1} END { print "-done-"}' /etc/passwd
```

### Basic Constructs
```awk
#Defining Variables
awk -v var1="Hello" -v var2="Wold" '
    END {print var1, var2}
' </dev/null

#Condition
awk -F: '$3>30 {print $3, NR, $1, $0}' /etc/passwd

#Looping
awk 'BEGIN{
    while (a++ < 1000)
        s=s " ";
    print s
}'

#Arrays
awk 'BEGIN {
   fruits["mango"] = "yellow";
   fruits["orange"] = "orange"
   for(fruit in fruits) {
     print "The color of " fruit " is " fruits[fruit]
   }
}'

#In built methods
# => 5
awk 'BEGIN{print length("hello")}'
# => HELLO
awk 'BEGIN{print toupper("hello")}'
# => hel
awk 'BEGIN{print substr("hello", 1, 3)}'
```

### Conditions
|Expression| Meaning|
|---|---|
|$1 == "root"|First field equals root|
|{print $(NF-1)}|Second last field|
|NR!=1{print $0}|From 2th record|
|NR > 3|From 4th record|
|NR == 1|First record|
|END{print NR}|Total records|
|BEGIN{print OFMT}|Output format|
|{print NR, $0}|Line number|
|{print NR " " $0}|Line number (tab)|
|{$1 = NR; print}|Replace 1st field with line number|
|$NF > 4|Last field > 4|
|NR % 2 == 0|Even records|
|NR==10, NR==20|Records 10 to 20|
|BEGIN{print ARGC}|Total arguments|
|ORS=NR%5?",":"\n"|Concatenate records|

### Examples
```awk
#Using Shell Variables
awk -v varName="$PWD" '
    END {print varName}' </dev/null


#Print Sum and Average
awk -F: '{sum += $3}
     END { print sum, sum/NR }
' /etc/passwd

#Print parameters
awk 'BEGIN {
    for (i = 1; i < ARGC; i++)
        print ARGV[i] }' a b c

#OFS as ,
awk 'BEGIN { FS=":";OFS=","}
    {print $1,$2,$3,$4}' /etc/passwd

#Location of Match
awk 'BEGIN {
    if (match("One Two Three", "Tw"))
        print RSTART }'

#Length of Match
awk 'BEGIN {
    if (match("One Two Three", "re"))
        print RLENGTH }'
```

## AWK Operators
#### Conditions
| Operator | Description |
|---|---|
|{print $1} |	First field
|$2 == "foo"| Equals
|$2 != "foo" |Not equals
|"foo" in array | In array

#### Regex
| Regex | Description |
|---|---|
/regex/	| Line matches
!/regex/ | Line not matches
$1 ~ /regex/ | Field matches
$1 !~ /regex/ | Field not matches

#### Logical Operators
| Usage | Description |
|---|---|
($2 <= 4 \|\| $3 < 20) | Or
($1 == 4 && $3 < 20) | And

### Common AWK functions
| Function | Description |
|---|---|
index(s,t) | Position in string s where string t occurs, 0 if not found
length(s) | Length of string s (or $0 if no arg)
rand | Random number between 0 and 1
substr(s,index,len) | Return len-char substring of s that begins at index (counted from 1)
srand | Set seed for rand and return previous seed
int(x) | Truncate x to integer value
split(s,a,fs) | Split string s into array a split by fs, returning length of a
match(s,r) | Position in string s where regex r occurs, or 0 if not found
sub(r,t,s) | Substitute t for first occurrence of regex r in string s (or $0 if s not given)
gsub(r,t,s) | Substitute t for all occurrences of regex r in string s
system(cmd) | Execute cmd and return exit status
tolower(s) | String s to lowercase
toupper(s) | String s to uppercase
getline | Set $0 to next input record from current input file


### User defined function
```awk
awk '
    # Returns minimum number
    function find_min(num1, num2){
       if (num1 < num2)
       return num1
       return num2
    }
    # Returns maximum number
    function find_max(num1, num2){
       if (num1 > num2)
       return num1
       return num2
    }
    # Main function
    function main(num1, num2){
       result = find_min(num1, num2)
       print "Minimum =", result
      
       result = find_max(num1, num2)
       print "Maximum =", result
    }
    # Script execution starts here
    BEGIN {
       main(10, 60)
    }
'
```

### AWK arrays
```awk
#Array with index
awk 'BEGIN {
    arr[0] = "foo";
    arr[1] = "bar";
    print(arr[0]); # => foo
    delete arr[0];
    print(arr[0]); # => ""
}'

#Array with key
awk 'BEGIN {
    assoc["foo"] = "bar";
    assoc["bar"] = "baz";
    print("baz" in assoc); # => 0
    print("foo" in assoc); # => 1
}'

#Array with split
awk 'BEGIN {
    split("foo:bar:baz", arr, ":");
    for (key in arr)
        print arr[key];
}'

#Array with asort
awk 'BEGIN {
    arr[0] = 3
    arr[1] = 2
    arr[2] = 4
    n = asort(arr)
    for (i = 1; i <= n ; i++)
        print(arr[i])
}'

#Multi-dimensional
awk 'BEGIN {
    multidim[0,0] = "foo";
    multidim[0,1] = "bar";
    multidim[1,0] = "baz";
    multidim[1,1] = "boo";
}'

#Iterate over multi-dimension
awk 'BEGIN {
    array[1,2]=3;
    array[2,3]=5;
    for (comb in array) {
        split(comb,sep,SUBSEP);
        print sep[1], sep[2], 
        array[sep[1],sep[2]]
    }
}'

```

### AWK conditions
```awk
#if else
awk -v count=2 'BEGIN {
    if (count == 1)
        print "Yes";
    else
        print "Huh?";
}'

#if exists
awk 'BEGIN {
    assoc["foo"] = "bar";
    assoc["bar"] = "baz";
    if ("foo" in assoc)
        print "Fooey!";
}'

#ternary
awk -v count=2 'BEGIN {
    print (count==1) ? "Yes" : "Huh?";
}'

# not exists
awk 'BEGIN {
    assoc["foo"] = "bar";
    assoc["bar"] = "baz";
    if ("Huh" in assoc == 0 )
        print "Huh!";
}'

#switch
awk -F: '{
    switch (NR * 2 + 1) {
        case 3:
        case "11":
            print NR - 1
            break
        
        case /2[[:digit:]]+/:
            print NR
        
        default:
            print NR + 1
        
        case -1:
            print NR * -1
    }
}' /etc/passwd
```

### Loops in AWK
```awk
#Simple for
awk 'BEGIN {
    for (i = 0; i < 10; i++)
        print "i=" i;
}'

#while
awk 'BEGIN {
    while (a < 10) {
        print "- " " concatenation: " a
        a++;
    }
}'

#do while
awk '{
    i = 1
    do {
        print $0
        i++
    } while (i <= 5)
}' /etc/passwd

#for in
awk 'BEGIN {
    assoc["key1"] = "val1"
    assoc["key2"] = "val2"
    for (key in assoc)
        print assoc[key];
}'

#Using break
awk 'BEGIN {
    break_num = 5
    for (i = 0; i < 10; i++) {
        print i
        if (i == break_num)
            break
    }
}'

#Using continue
awk 'BEGIN {
    for (x = 0; x <= 10; x++) {
        if (x == 5 || x == 6)
            continue
        printf "%d ", x
    }
    print ""
}'
```

### Text formatting
```awk
#Right align
awk 'BEGIN{printf "|%10s|\n", "hello"}'

#Left align
awk 'BEGIN{printf "|%-10s|\n", "hello"}'

|     hello|


awk -F: 'BEGIN {
    printf "%-10s %s\n", "User", "Home"
    printf "%-10s %s\n", "----","----"}
    { printf "%-10s %s\n", $1, $(NF-1) }
' /etc/passwd
```
 