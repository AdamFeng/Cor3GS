#!/usr/bin/python
#-*- coding:utf-8 -*-

# usage: python 09_cor_3gs_fq_with_corinfo.py  cor_info.txt  fastq_file   corrected_fq_file

import os,sys

if len(sys.argv) != 4:
    print 'usage: python 09_cor_3gs_fq_with_corinfo.py  cor_info.txt  fastq_file  corrected_fq_file'
    exit(1)

info = sys.argv[1]
fq_file = sys.argv[2]
new_fq_file = open(sys.argv[3], 'w')
seq_dict = {}
qua_dict = {}


with open(fq_file, 'r') as fq:
    for line in fq:
        if line[0] == '@':
            key = line[0:(len(line)-1)]
        if line[0] == 'A' or line[0] == 'T' or line[0] == 'C' or line[0] == 'G':
            value = line
            seq_dict[key] = value            
        if line[0] != 'A' and line[0] != 'T' and line[0] != 'C' and line[0] != 'G' and line[0] != '+' and line[0] != '@':
            value = line
            qua_dict[key] = value

with open(info, 'r') as infor:
    for line in infor:
        seq_name = line.split('\t')[0]
        pos = line.split('\t')[1]
        ref = line.split('\t')[2]
        alt = line.split('\t')[3][0:(len(line.split('\t')[3])-1)]
        seq_atcg = seq_dict[seq_name]
        try:
            seq_qua = qua_dict[seq_name]
        except:
            pass

        #对序列进行纠错
        pre_atcg_seq = seq_atcg[0:int(pos)-1] # 前半段正确序列
        beh_atcg_seq = seq_atcg[int(pos)-1:len(seq_atcg)] # 从有错序列开始的后半序列

        # 对有错的后半段序列进行处理
        cor_beh_atcg_seq = beh_atcg_seq.replace(str(ref),str(alt),1)
        correct_atcgseq = pre_atcg_seq + cor_beh_atcg_seq
        seq_dict[seq_name] = correct_atcgseq

        # 对质量进行纠错
        #qua_seq = seq_qua[0:int(pos)-1] + len(alt) * '?' + seq_qua[int(pos)+len(ref):len(seq_qua)]
        #qua_dict[seq_name] = qua_seq
        pre_qua_seq = seq_qua[0:int(pos)-1] # 前半段正确序列
        beh_qua_seq = seq_qua[int(pos)-1:len(seq_qua)] # 从有错序列开始的后半序列
        beh_qua_seq_copy = beh_qua_seq

        # # 对有错的后半段序列进行处理
        cor_beh_qua_seq = len(alt)*'?' + beh_qua_seq[len(ref):len(beh_qua_seq)]
        correct_quaseq = pre_qua_seq + cor_beh_qua_seq
        qua_dict[seq_name] = correct_quaseq

for key in seq_dict:
    new_fq_file.write(key)
    new_fq_file.write('\n')
    new_fq_file.write(seq_dict[key])
    new_fq_file.write('+')
    new_fq_file.write('\n')
    try:
        new_fq_file.write(qua_dict[key])
    except:
        pass


# for key in seq_dict:
#     print 'seq_dict: ', key, ': ', seq_dict[key]

# for key in qua_dict:
#     print 'qua_dict: ', key, ': ', qua_dict[key]

