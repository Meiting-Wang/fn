#!/bin/bash
###################update repository##################


#-------------本脚本无需修改------------
time=$(date "+%Y-%m-%d %H:%M:%S")

git add .

if [ "$1" ]
then
    git commit -m "$1"
else
    git commit -m "update on ${time}"
fi

git push