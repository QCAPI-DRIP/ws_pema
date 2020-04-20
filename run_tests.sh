#!/bin/bash

yourprojectname=cur_example
host=localhost:8080

curl -v -X PUT http://$host/$yourprojectname

filename=test_dataset/parameters.tsv
