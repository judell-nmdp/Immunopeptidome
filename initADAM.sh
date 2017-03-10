#!/bin/sh

# The typical use case for ADAM is:
# deploy an Apache Spark cluster on AWS
echo 'Instance type?'
read instancevar
echo 'Number of instance nodes? ('
read nodevar
echo 'Spinning up Apache Spark cluster & entering spark-master'
cgcloud create-cluster \
    --zone us-east-1e \
    --vpc vpc-dd328bbb \
    --subnet subnet-3c49f100 \
    --cluster-name cluster1 \
    --num-workers $nodevar \
    --instance-type $instancevar \
    spark

cgcloud ssh \
    --zone us-east-1e \
    --cluster-name cluster1 \
    spark-master
    
echo 'Installing ADAM binary...'
wget https://repo1.maven.org/maven2/org/bdgenomics/adam/adam-distribution_2.10/0.21.0/adam-distribution_2.10-0.21.0-bin.tar.gz
tar -xvzf adam-distribution_2.10-0.21.0-bin.tar.gz
cd adam-distribution_2.10-0.21.0



# transfer data from S3 to HDFS on the Apache Spark cluster
# transform the data on HDFS with adam-submit, and/or
# query interactively the data on HDFS with adam-shell or a workbook
# write any transformed data or analysis results to HDFS
# transfer transformed data or analysis results from HDFS to S3
# terminate the Apache Spark cluster