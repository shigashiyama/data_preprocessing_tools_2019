## Files 

- ClassA-1.list  
    list of document IDs in ClassA-1 (test set).  
    The original file can be downloaded from  
    <http://plata.ar.media.kyoto-u.ac.jp/mori/research/topics/PST/NextNLP.html>
- core.list  
    list of document IDs in BCCWJ core data
- create_dataset.sh  
    script to create dataset


## How to create dataset

(1) unzip the following input files

- BCCWJ1.1/Disk3/CORE_OT/core_SUW.zip
- BCCWJ1.1/Disk3/CORE_OT/core_LUW.zip

(2) execute data creation script

Change arguments in create_dataset.sh

- input:  path of input file core_SUW.txt
- outdir: paht of output directory

Execute the script

~~~~
$ ./create_dataset.sh
~~~~