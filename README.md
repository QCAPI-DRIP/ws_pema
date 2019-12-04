# ws_pema
wrapp  pema as REST web service 



## Call with curl

```
yourprojectname=cur_example
```
```
curl -v -X PUT http://$host/$yourprojectname
```
```
filename=parameters.tsv
```
```
inputtemplate=metadata
```
```
curl -v -F "inputtemplate=$inputtemplate" -F "file=@/home/alogo/Downloads/Example_VRE/good_data3/parameters.tsv" http://$host/$yourprojectname/input/$filename
```

