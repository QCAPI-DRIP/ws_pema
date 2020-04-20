#!/bin/bash

yourprojectname=cur_example
host=localhost:8080

curl -v -X PUT http://$host/$yourprojectname

filename=test_dataset/parameters.tsv
inputtemplate=metadata
curl -v -F "inputtemplate=$inputtemplate" -F "file=@test_dataset/$filename" http://$host/$yourprojectname/input/$filename


filename=ERR1906859_1.fastq.gz
inputtemplate=mydata
curl -v -F "inputtemplate=$inputtemplate" -F "file=@test_dataset/$filename" http://$host/$yourprojectname/input/$filename

