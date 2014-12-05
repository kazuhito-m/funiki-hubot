#!/bin/bash

echo 'exec import !'
cat initial_data.txt  | perl -pe 's/\n$/\r\n/g' |redis-cli --pipe
echo 'import end.'
