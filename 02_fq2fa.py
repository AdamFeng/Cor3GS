#!/usr/bin/python
def fastaq_2_fasta(fastaq):
    fasta_dict = {}
    fasta_q_split = fastaq.split('\n+\n')[:-1]
    for fastaq in fasta_q_split:
        fasta = fastaq.split('\n')[-2:]
        fasta_dict['>'+fasta[0]] = fasta[1] 
    return fasta_dict
 
file_read_name = 'ecoli_filtered.fastq'
 
with open(file_read_name) as fastafile:
    fileRead = fastafile.read()
 
fasta = fastaq_2_fasta(fileRead)
 
file_save_name = 'ecoli_filtered.fasta'
 
with open(file_save_name,'w') as save_file:
    for name in fasta:
        string = name+'\n'+fasta[name]+'\n'
        save_file.write(string)
