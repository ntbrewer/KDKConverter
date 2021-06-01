#!/bin/bash
# a convenience script for running one ldf at a time.
#
# usage ./run.sh file_name.ldf
# or ./run.sh LDF/file_name.ldf -d
# if multiple ldf's are wished to be scanned at once, 
# edit ./source/config/outputfile_names.txt to contain the correct files,
# then create a cmd file, with the format :
# file LDF/file_name1.ldf
# go
# file LDF/file_name2.ldf
# go ... etc
# and run kdk_converter in the terminal as ./kdk_converter his_name < cmd_name.cmd
###########
ldfname=$1
flag=0

if ! [ -e $ldfname ] ; then 
   echo "invalid input of ldf name"
   echo "file not found" 
   exit 1 
fi

if [ ${#ldfname} -lt 8 ] ; then 
   echo "Using default names"
   flag=1
else 
   part=${ldfname:4:-4}  #drops LDF/ and .ldf each len 4.
   if [ -z $part ] ; then
      echo "Using default names"
      flag=1
   fi
fi

if [ ! -z $2 ] ; then
  if [ $2 = "-d" ] ; then
    echo "Using default names" 
    flag=1
  fi
fi

if [ $flag -eq 1 ] ; then 
   cp ./source/config/outputfile_names.default ./source/config/outputfile_names.txt
   echo "done"
else 
#   echo $part"APD.bin" > ./source/config/outputfile_names.txt
   echo $part"_Events.txt" > ./source/config/outputfile_names.txt
   echo "new config made"
fi

echo "running kdk_converter from cmd"
echo "file $ldfname" > temp.cmd
echo " go 1,2000" >> temp.cmd 
echo " end " >> temp.cmd
./kdk_converter $part < temp.cmd  
echo "done"
exit 1
