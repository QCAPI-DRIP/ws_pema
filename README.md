# ws_pema
wrapp  pema as REST web service 



## Call with curl
### Create a project
```
yourprojectname=cur_example
```
```
curl -v -X PUT http://$host/$yourprojectname
```
### Upload files
```
filename=parameters.tsv
```
```
inputtemplate=metadata
```
```
curl -v -F "inputtemplate=$inputtemplate" -F "file=@Downloads/Example_VRE/good_data3/parameters.tsv" http://$host/$yourprojectname/input/$filename
```

```
filename=ERR1906859_1.fastq.gz
```
```
inputtemplate=mydata
```

```
curl -v -F "inputtemplate=$inputtemplate" -F "file=@Downloads/Example_VRE/good_data3/$filename" http://$host/$yourprojectname/input/$filename
```

```
filename=ERR1906859_2.fastq.gz
```
```
curl -v -F "inputtemplate=$inputtemplate" -F "file=@Example_VRE/good_data3/ERR1906859_2.fastq.gz" http://$host/$yourprojectname/input/$filename
```
### Start project execution 
```
curl -v -X POST http://$host/$yourprojectname/
```
### Poll the project status with a regular interval and check its status until it is flagged as finished
```
curl -v -X GET http://$host/$yourprojectname
```
Will respond with HTTP 200 OK if successful, and returns the CLAM XML for the project's current state. The state of the project is stored in the CLAM XML response, in /CLAM/status/@code/ (XPath), this code takes on one of three values:
0 - The project is in an accepting state, accepting file uploads and waiting to be started
1 - The project is in execution
2 - The project has finished
### Retrieve the desired output file(s
```
curl -v http://$host/$yourprojectname/output/$outputfilename
```

## Pull Docker
The docer image is located in : https://hub.docker.com/repository/docker/alogo53/ws-pema-lifewatch
To pull the image type:
```
docker pull alogo53/ws-pema-lifewatch
```

## Start Docker
Start the docker container: 
```
sudo docker run -p 8080:8080 -it ws-pema-lifewatch
```

## Sample Data
https://surfdrive.surf.nl/files/index.php/s/E6kY0h3C4Tan4vA

