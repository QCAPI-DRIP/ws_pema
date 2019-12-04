#!/usr/bin/env python
#-*- coding:utf-8 -*-

###############################################################
# CLAM: Computational Linguistics Application Mediator
# -- CLAM Wrapper script Template --
#       by Maarten van Gompel (proycon)
#       https://proycon.github.io/clam
#       Centre for Language and Speech Technology
#       Radboud University Nijmegen
#
#       (adapt or remove this header for your own code)
#
#       Licensed under GPLv3
#
###############################################################

#This is a template wrapper which you can use a basis for writing your own
#system wrapper script. The system wrapper script is called by CLAM, it's job it
#to call your actual tool.

#This script will be called by CLAM and will run with the current working directory set to the specified project directory

#This wrapper script uses Python and the CLAM Data API.
#We make use of the XML settings file that CLAM outputs, rather than
#passing all parameters on the command line.


#import some general python modules:
#import some general python modules:
import sys

#import CLAM-specific modules. The CLAM API makes a lot of stuff easily accessible.
import clam.common.data
import clam.common.status
import os
import shutil
import glob
import errno

#When the wrapper is started, the current working directory corresponds to the project directory, input files are in input/ , output files should go in output/ .

#make a shortcut to the shellsafe() function
shellsafe = clam.common.data.shellsafe

#this script takes three arguments from CLAM: $DATAFILE $STATUSFILE $OUTPUTDIRECTORY
#(as configured at COMMAND= in the service configuration file, there you can
#reconfigure which arguments are passed and in what order.
datafile = sys.argv[1]
statusfile = sys.argv[2]
outputdir = sys.argv[3]

#If you make use of CUSTOM_FORMATS, you need to import your service configuration file here and set clam.common.data.CUSTOM_FORMATS
#Moreover, you can import any other settings from your service configuration file as well:

#from yourserviceconf import CUSTOM_FORMATS
#clam.common.data.CUSTOM_FORMATS = CUSTOM_FORMATS

#Obtain all data from the CLAM system (passed in $DATAFILE (clam.xml)), always pass CUSTOM_FORMATS as second argument if you make use of it!
clamdata = clam.common.data.getclamdata(datafile)

#You now have access to all data. A few properties at your disposition now are:
# clamdata.system_id , clamdata.project, clamdata.user, clamdata.status , clamdata.parameters, clamdata.inputformats, clamdata.outputformats , clamdata.input , clamdata.output

clam.common.status.write(statusfile, "Starting...")


try:
    os.makedirs("/mnt/analysis/mydata", exist_ok=True);
except OSError as e:
    if e.errno != errno.EEXIST:
        raise
    
    
fieldlist_path='';
imglist_path='';
for inputfile in clamdata.input:
  inputtemplate = inputfile.metadata.inputtemplate
  inputfilepath = str(inputfile)
  #encoding = inputfile.metadata['encoding'] #Example showing how to obtain metadata parameters
  #clam.common.status.write(statusfile, "inputfilepath: "+inputfilepath)
  #clam.common.status.write(statusfile, "encoding: "+encoding)
  ext = os.path.splitext(inputfilepath)[1]
  clam.common.status.write(statusfile, "ext: "+ext);
  if (ext == '.gz'):
      newPath = shutil.move(inputfilepath, "/mnt/analysis/mydata");
      clam.common.status.write(statusfile, "Moved: "+inputfilepath);
  if (ext == '.tsv'):
      newPath = shutil.move(inputfilepath, "/mnt/analysis/");
      clam.common.status.write(statusfile, "Moved: "+inputfilepath); 

cwd = os.getcwd()
newPath = shutil.move('/home/', "/mnt/analysis/mydata");




clam.common.status.write(statusfile, "Calling: "+"PEMA_v1.bds");
result = os.system("/home/tools/BDS/.bds/bds PEMA_v1.bds");


clam.common.status.write(statusfile, "Done",100) # status update

sys.exit(result) #non-zero exit codes indicate an error and will be picked up by CLAM as such!
