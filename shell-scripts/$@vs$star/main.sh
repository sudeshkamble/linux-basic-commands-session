echo '$* without quotes:'
./method.sh $*

echo '$@ without quotes:'
./method.sh $@

echo '$* with quotes:'
./method.sh "$*"

echo '$@ with quotes:'
./method.sh "$@"