#!/bin/sh

echo 'Loading ExAC data...'
# see ftp://ftp.broadinstitute.org/pub/ExAC_release/release1/
hadoop fs -mkdir -p /data
hadoop fs -mkdir -p /tmp
 
wget -P /tmp ftp://ftp.broadinstitute.org/pub/ExAC_release/release1/ExAC.r1.sites.vep.vcf.gz
hadoop fs -cat /tmp/ExAC.r1.sites.vep.vcf.gz | tabix -p vcf  | hadoop fs -put - /data
