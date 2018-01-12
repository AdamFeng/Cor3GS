#!/usr/bin/python
#-*- coding:utf-8 -*-

#usage: python split_pac2reads.py pac_file

import os,sys

if len(sys.argv) < 2:
	print "usage: python split_pac2reads.py pac_file"
	exit(1)

pac_file = open(sys.argv[1], 'r')
i = 0 # 控制符
for line in pac_file:	
	if i % 4 == 0:
		split_read = open('./split_fq/read_%s' % i, 'w')
		split_read.write(line)
		i = i + 1
	else:
		split_read.write(line)
		i = i + 1

 