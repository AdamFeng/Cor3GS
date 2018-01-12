#!/usr/bin/python
# -*- coding:utf_8 -*-

import sys,os
if (len(sys.argv) < 2):
    print("usage: python cal_ave_error_rate.py error_file")
    exit(1)

error_file = open(sys.argv[1], 'r')
error_rate = 0
i = 1
for line in error_file:
    error_rate += float(line.split('=')[1])
    i += 1
print('error_rate = %f' % error_rate)
print('i = %d' % i)
print("ave_error_rate = %.4f" % (error_rate / i))