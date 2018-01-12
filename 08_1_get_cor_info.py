#!/usr/bin/python
# -*- coding:utf-8 -*-

# usage: python 08_get_cor_info.py  vcf_file output_file

import os,sys

if len(sys.argv) < 3:
	print 'usage:python 08_get_cor_info.py  vcf_file output_file'
	exit(1)
	
vcf_file = sys.argv[1]
output_file = sys.argv[2]

output = open(output_file, 'w')
with open(vcf_file, 'r') as vcf:
	for line in vcf:
		if line[0] == '#' :
			pass
		else:
			output.write(line)
			
output.close()