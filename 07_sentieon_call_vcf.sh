#!/bin/bash

#usage: bash 06_sentieon_call_vcf.sh fasta_file fq_1_file fq_2_file mark
#									 $1          $2        $3        $4

# Other settings
nt=24 #number of threads to use in computation
workdir="$PWD/call_vcf_10X_30X" #Determine where the output files will be stored


# ******************************************
# 0. Setup
# ******************************************
mkdir -p $workdir
mkdir $workdir/$4
logfile=$workdir/$4/$4.run.log
exec >$logfile 2>&1

# ******************************************
# 0. Process all samples independently
# ******************************************
#update with the prefix of the fastq files

#cd $workdir/$4

# ******************************************
# 1. Mapping reads with BWA-MEM, sorting
# ******************************************
bwa mem -M -R '@RG\tID:ecoli_2fq\tSM:ecoli_3fa\tPL:ILLUMINA' -t $nt $1 $2 $3 | sentieon util sort -o $workdir/$4/sorted_$4.bam -t $nt --sam2bam -i -

# ******************************************
# 2. Metrics
# ******************************************
sentieon driver -r $1 -t $nt -i $workdir/$4/sorted_$4.bam --algo MeanQualityByCycle $workdir/$4/$4.mq_metrics.txt --algo QualDistribution $workdir/$4/$4.qd_metrics.txt --algo GCBias --summary $workdir/$4/$4.gc_summary.txt $workdir/$4/$4.gc_metrics.txt --algo AlignmentStat --adapter_seq '' $workdir/$4/$4.aln_metrics.txt --algo InsertSizeMetricAlgo $workdir/$4/$4.is_metrics.txt
sentieon plot metrics -o $workdir/$4/$4.metrics-report.pdf gc=$workdir/$4/$4.gc_metrics.txt qd=$workdir/$4/$4.qd_metrics.txt mq=$workdir/$4/$4.mq_metrics.txt isize=$workdir/$4/$4.is_metrics.txt

# ******************************************
# 3. Remove Duplicate Reads
# ******************************************
sentieon driver  -t $nt -i $workdir/$4/sorted_$4.bam --algo LocusCollector --fun score_info $workdir/$4/$4.score.txt
sentieon driver  -t $nt -i $workdir/$4/sorted_$4.bam --algo Dedup --rmdup --score_info $workdir/$4/$4.score.txt --metrics $workdir/$4/$4.dedup_metrics.txt $workdir/$4/$4.deduped.bam 

# ******************************************
# 4. Indel realigner
# ******************************************
sentieon driver -r $1  -t $nt -i $workdir/$4/$4.deduped.bam --algo Realigner  $workdir/$4/$4.realigned.bam

# ******************************************
# 5. Base recalibration
# ******************************************
sentieon driver -r $1 -t $nt -i $workdir/$4/$4.realigned.bam --algo QualCal  $workdir/$4/$4.recal_data.table
sentieon driver -r $1 -t $nt -i $workdir/$4/$4.realigned.bam -q $workdir/$4/$4.recal_data.table --algo QualCal $workdir/$4/$4.recal_data.table.post
sentieon driver -t $nt --algo QualCal --plot --before $workdir/$4/$4.recal_data.table --after $workdir/$4/$4.recal_data.table.post $workdir/$4/$4.recal.csv
sentieon plot bqsr -o $workdir/$4/$4.recal_plots.pdf $workdir/$4/$4.recal.csv

# ******************************************
# 6b. HC Variant caller for GVCF
# ******************************************
sentieon driver -r $1  -t $nt -i $workdir/$4/$4.realigned.bam -q $workdir/$4/$4.recal_data.table --algo Haplotyper $workdir/$4/$4.split_10X.vcf
