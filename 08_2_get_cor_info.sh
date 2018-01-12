#!/bin/bash
# usage: bash  08_2_get_cor_info.sh  nohead_vcf_file  output_file

if [ $# != 2 ] ; then 
echo "usage: bash  08_2_get_cor_info.sh  nohead_vcf_file  output_file"
exit 1; 
fi 

cat $1 | awk '{print $1 "\t" $2 "\t"  $4  "\t"  $5}' > $2