#!/usr/bin/python
# -*- coding:utf_8 -*-

import sys,os
if (len(sys.argv) < 2):
    print("usage: python cal_error_rate.py sam_file")
    exit(1)

sam = open(sys.argv[1], 'r')
j = 0 # 读取比对结果行首字符
error = 0
total = 0
while 1:
    line = sam.readline()
    if not line:
        break
    if line[0] != '@':
        total += float(line.split('\t')[0].split('/')[2].split('_')[1]) - float(line.split('\t')[0].split('/')[2].split('_')[0])
        mapping_results = line.split('\t')[5]
        while 1:
            if (mapping_results[j] == 'I' or mapping_results[j] == 'D'):
                error += float(mapping_results[j-1])
            j += 1
            if j >= len(mapping_results):
                j = 0
                break
print("error = %d" % error)
print("total = %d" % total)
print("error rate = %.4f" % (error / total))
