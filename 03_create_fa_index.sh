#!/bin/bash
ls split_fa_10X/* > fa.list
sed 's/^/samtools faidx /g' fa.list > samtools_faidx_10X.list
sed 's/^/bwa index /g' fa.list > bwa_index_10X.list



ls split_fa_20X/* > fa.list
sed 's/^/samtools faidx /g' fa.list > samtools_faidx_20X.list
sed 's/^/bwa index /g' fa.list > bwa_index_20X.list


ls split_fa_30X/* > fa.list
sed 's/^/samtools faidx /g' fa.list > samtools_faidx_30X.list
sed 's/^/bwa index /g' fa.list > bwa_index_30X.list

bash samtools_faidx_10X.list
bash bwa_index_10X.list

bash samtools_faidx_20X.list
bash bwa_index_20X.list

bash samtools_faidx_30X.list
bash bwa_index_30X.list