#!/bin/bash
ls split_fq_10X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " >sam_file_10X/"$2}' > cmd.list
sed -i 's/$/.sam/g' cmd.list
sed "s/^/bwa mem -M -R '@RG\tID:ecoli\tSM:K12Seq\tPL:PacBio' -t 24 \/share\/home\/yanpc\/gaof\/vcf_imp_fq\/ecoli_K12\/fasta\/GCF_000005845.2_ASM584v2_genomic.fna /g" cmd.list > cmd_10X.list


ls split_fq_20X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " >sam_file_20X/"$2}' > cmd.list
sed -i 's/$/.sam/g' cmd.list
sed "s/^/bwa mem -M -R '@RG\tID:ecoli\tSM:K12Seq\tPL:PacBio' -t 24 \/share\/home\/yanpc\/gaof\/vcf_imp_fq\/ecoli_K12\/fasta\/GCF_000005845.2_ASM584v2_genomic.fna /g" cmd.list > cmd_20X.list


ls split_fq_30X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " >sam_file_30X/"$2}' > cmd.list
sed -i 's/$/.sam/g' cmd.list
sed "s/^/bwa mem -M -R '@RG\tID:ecoli\tSM:K12Seq\tPL:PacBio' -t 24 \/share\/home\/yanpc\/gaof\/vcf_imp_fq\/ecoli_K12\/fasta\/GCF_000005845.2_ASM584v2_genomic.fna /g" cmd.list > cmd_30X.list

bash cmd_10X.list
bash cmd_20X.list
bash cmd_30X.list