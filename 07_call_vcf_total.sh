#!/bin/bash

#usage: bash call_vcf_total.sh fasta_file fq_1_file fq_2_file
#  					 $1         $2       $3     

# Other settings
nt=24 #number of threads to use in computation
workdir="$PWD/call_vcf_NGS23GS" #Determine where the output files will be stored


# ******************************************
# 0. Setup
# ******************************************
mkdir -p $workdir/$1
logfile=$workdir/$1/$1.run.log
exec >$logfile 2>&1

# ******************************************
# 0. Process all samples independently
# ******************************************
#update with the prefix of the fastq files

#cd $workdir/$1

# ******************************************
# 1. Mapping reads with BWA-MEM, sorting
# ******************************************
bwa mem -M -R '@RG\tID:ecoli_2fq\tSM:ecoli_3fa\tPL:ILLUMINA' -t $nt $1 $2 $3 | sentieon util sort -o $workdir/$1/sorted_$1.bam -t $nt --sam2bam -i -

# ******************************************
# 2. Metrics
# ******************************************
sentieon driver -r $1 -t $nt -i $workdir/$1/sorted_$1.bam --algo MeanQualityByCycle $workdir/$1/$1.mq_metrics.txt --algo QualDistribution $workdir/$1/$1.qd_metrics.txt --algo GCBias --summary $workdir/$1/$1.gc_summary.txt $workdir/$1/$1.gc_metrics.txt --algo AlignmentStat --adapter_seq '' $workdir/$1/$1.aln_metrics.txt --algo InsertSizeMetricAlgo $workdir/$1/$1.is_metrics.txt
sentieon plot metrics -o $workdir/$1/$1.metrics-report.pdf gc=$workdir/$1/$1.gc_metrics.txt qd=$workdir/$1/$1.qd_metrics.txt mq=$workdir/$1/$1.mq_metrics.txt isize=$workdir/$1/$1.is_metrics.txt

# ******************************************
# 3. Remove Duplicate Reads
# ******************************************
sentieon driver  -t $nt -i $workdir/$1/sorted_$1.bam --algo LocusCollector --fun score_info $workdir/$1/$1.score.txt
sentieon driver  -t $nt -i $workdir/$1/sorted_$1.bam --algo Dedup --rmdup --score_info $workdir/$1/$1.score.txt --metrics $workdir/$1/$1.dedup_metrics.txt $workdir/$1/$1.deduped.bam 

# ******************************************
# 4. Indel realigner
# ******************************************
sentieon driver -r $1  -t $nt -i $workdir/$1/$1.deduped.bam --algo Realigner  $workdir/$1/$1.realigned.bam

# ******************************************
# 5. Base recalibration
# ******************************************
sentieon driver -r $1 -t $nt -i $workdir/$1/$1.realigned.bam --algo QualCal  $workdir/$1/$1.recal_data.table
sentieon driver -r $1 -t $nt -i $workdir/$1/$1.realigned.bam -q $workdir/$1/$1.recal_data.table --algo QualCal $workdir/$1/$1.recal_data.table.post
sentieon driver -t $nt --algo QualCal --plot --before $workdir/$1/$1.recal_data.table --after $workdir/$1/$1.recal_data.table.post $workdir/$1/$1.recal.csv
sentieon plot bqsr -o $workdir/$1/$1.recal_plots.pdf $workdir/$1/$1.recal.csv

# ******************************************
# 6b. HC Variant caller for GVCF
# ******************************************
sentieon driver -r $1  -t $nt -i $workdir/$1/$1.realigned.bam -q $workdir/$1/$1.recal_data.table --algo Haplotyper $workdir/$1/$1.split_10X.vcf

