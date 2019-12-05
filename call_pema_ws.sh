!#/bin/bash

# ./call_pema_ws.sh --ws-url=http://host  --project-name=1 --parameters-file=/home/alogo/Downloads/Example_VRE/good_data3/parameters.tsv  --fastq-dir=/home/alogo/Downloads/Example_VRE/good_data3/mydata/

print_help () {
echo "--ws_url:             The web service url. e.g. --ws_url http://host:8080/"
echo "--project_name:       The name to create a project in the web service --project_name analysis01"
echo "--parameters_file:    The parameters_file --parameters_file parameters.tsv"
# echo "--fastq_dir:          The folder where the fastq data are located. Warning !!! This folder must contain ONLY  .fastq.gz files"
echo "--fastq_zip:          The zip file with fastq data are located."
}


for i in "$@"
do
case $i in
    --ws-url=*)
    WS_URL=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`

    ;;
    --project-name=*)
    PROJECT_NAME=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    --parameters-file=*)
    PARAMETERS_FILE=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;

#     --fastq-dir=*)
#     FASTQ_DIR=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
#     ;;
#     *)
    --fastq-zip=*)
    FASTQ_ZIP=`echo $i | sed 's/[-a-zA-Z0-9]*=//'`
    ;;
    *)    
#            print_help # unknown option
    ;;
esac
done

FASTQ_DIR=/tmp/pema_input
mkdir -p $FASTQ_DIR
unzip $FASTQ_ZIP -d $FASTQ_DIR

STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -X PUT $WS_URL/$PROJECT_NAME)

if [ $STATUS_CODE -eq 201 ]; then
    echo "Project created"
else
    echo "Got $STATUS :( Something is wrong..."
fi
  
  
  
inputtemplate=metadata
STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -F "inputtemplate=$inputtemplate" -F "file=@$PARAMETERS_FILE" $WS_URL/$PROJECT_NAME/input/parameters.tsv)
echo "STATUS_CODE=$STATUS_CODE"

if [ $STATUS_CODE -eq 200 ]; then
    echo "Uploaded $PARAMETERS_FILE "
else
    echo "Got $STATUS :( Something is wrong..."
fi


for file in $FASTQ_DIR/*; do 
    if [ -f "$file" ]; then
        filename=$(basename $file)
        inputtemplate=mydata
        STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -F "inputtemplate=$inputtemplate" -F "file=@$file" $WS_URL/$PROJECT_NAME/input/$filename)
        
        echo "STATUS_CODE=$STATUS_CODE"
        if [ $STATUS_CODE -eq 200 ]; then
            echo "Uploaded $file"
        else
            echo "Got $STATUS :( Something is wrong..."
        fi
    fi 
done

STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -X POST $WS_URL/$PROJECT_NAME/)
if [ $STATUS_CODE -eq 202 ]; then
    echo "Execution started"
else
    echo "Got $STATUS :( Something is wrong..."
fi

output_message=`curl -X GET $WS_URL/$PROJECT_NAME/`
DONE=false
while [ DONE==false ]
do
    output_message=`curl -X GET $WS_URL/$PROJECT_NAME/`
    if [[ $output_message == *"<status code=\"2\""* ]]; then
        DONE=true
        break
    fi
    echo "Waiting for service"
    echo $output_message
    sleep 2
done

echo $output_message
echo "Execution done"
curl -v $WS_URL/$PROJECT_NAME/output/gz/ -o $PROJECT_NAME.tar.gz
# tar -xvzf $PROJECT_NAME.tar.gz
mkdir -p /tmp/pema_output/$PROJECT_NAME
tar -xvzf $PROJECT_NAME.tar.gz -C /tmp/pema_output/$PROJECT_NAME

echo /tmp/pema_output/$PROJECT_NAME/16S_final_test
exit 0
