
# 对10X,20X,30X的PacBio数据和30X的二代数据进行实验

sed  's/$/ ngs_30X_fq\/ERR022075_30X_1.fq /g' fa_10X.list > sentieon_cmd_10.list
sed  's/$/ ngs_30X_fq\/ERR022075_30X_1.fq /g' fa_20X.list > sentieon_cmd_20.list
sed  's/$/ ngs_30X_fq\/ERR022075_30X_1.fq /g' fa_30X.list > sentieon_cmd_30.list

sed -i 's/$/ ngs_30X_fq\/ERR022075_30X_2.fq /g' sentieon_cmd_10.list
sed -i 's/$/ ngs_30X_fq\/ERR022075_30X_2.fq /g' sentieon_cmd_20.list
sed -i 's/$/ ngs_30X_fq\/ERR022075_30X_2.fq /g' sentieon_cmd_30.list

cat sentieon_cmd_10.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_10X30.list
sed -i 's/ngs_30X_fq$//g' sentieon_cmd_10X30.list
cat sentieon_cmd_20.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_20X30.list
sed -i 's/ngs_30X_fq$//g' sentieon_cmd_20X30.list
cat sentieon_cmd_30.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_30X30.list
sed -i 's/ngs_30X_fq$//g' sentieon_cmd_30X30.list

rm -rf sentieon_cmd_10.list sentieon_cmd_20.list sentieon_cmd_30.list

sed -i 's/^/bash  06_sentieon_call_vcf.sh_10X30  /g' sentieon_cmd_10X30.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_20X30  /g' sentieon_cmd_20X30.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_30X30  /g' sentieon_cmd_30X30.list

# bash sentieon_cmd_10X30.list
# bash sentieon_cmd_20X30.list
# bash sentieon_cmd_30X30.list



# 对10X,20X,30X的PacBio数据和60X的二代数据进行实验

sed  's/$/ ngs_60X_fq\/ERR022075_60X_1.fq /g' fa_10X.list > sentieon_cmd_10.list
sed  's/$/ ngs_60X_fq\/ERR022075_60X_1.fq /g' fa_20X.list > sentieon_cmd_20.list
sed  's/$/ ngs_60X_fq\/ERR022075_60X_1.fq /g' fa_30X.list > sentieon_cmd_30.list

sed -i 's/$/ ngs_60X_fq\/ERR022075_60X_2.fq /g' sentieon_cmd_10.list
sed -i 's/$/ ngs_60X_fq\/ERR022075_60X_2.fq /g' sentieon_cmd_20.list
sed -i 's/$/ ngs_60X_fq\/ERR022075_60X_2.fq /g' sentieon_cmd_30.list

cat sentieon_cmd_10.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_10X60.list
sed -i 's/ngs_60X_fq$//g' sentieon_cmd_10X60.list
cat sentieon_cmd_20.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_20X60.list
sed -i 's/ngs_60X_fq$//g' sentieon_cmd_20X60.list
cat sentieon_cmd_30.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_30X60.list
sed -i 's/ngs_60X_fq$//g' sentieon_cmd_30X60.list

rm -rf sentieon_cmd_10.list sentieon_cmd_20.list sentieon_cmd_30.list

sed -i 's/^/bash  06_sentieon_call_vcf.sh_10X60  /g' sentieon_cmd_10X60.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_20X60  /g' sentieon_cmd_20X60.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_30X60  /g' sentieon_cmd_30X60.list

# bash sentieon_cmd_10X60.list
# bash sentieon_cmd_20X60.list
# bash sentieon_cmd_30X60.list



# 对10X,20X,30X的PacBio数据和90X的二代数据进行实验

sed  's/$/ ngs_90X_fq\/ERR022075_90X_1.fq /g' fa_10X.list > sentieon_cmd_10.list
sed  's/$/ ngs_30X_fq\/ERR022075_90X_1.fq /g' fa_20X.list > sentieon_cmd_20.list
sed  's/$/ ngs_90X_fq\/ERR022075_90X_1.fq /g' fa_30X.list > sentieon_cmd_30.list

sed -i 's/$/ ngs_90X_fq\/ERR022075_90X_2.fq /g' sentieon_cmd_10.list
sed -i 's/$/ ngs_90X_fq\/ERR022075_90X_2.fq /g' sentieon_cmd_20.list
sed -i 's/$/ ngs_90X_fq\/ERR022075_90X_2.fq /g' sentieon_cmd_30.list

cat sentieon_cmd_10.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_10X90.list
sed -i 's/ngs_90X_fq$//g' sentieon_cmd_10X90.list
cat sentieon_cmd_20.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_20X90.list
sed -i 's/ngs_90X_fq$//g' sentieon_cmd_20X90.list
cat sentieon_cmd_30.list | awk 'BEGIN {FS="/"} {print $0 "  " $2}' > sentieon_cmd_30X90.list
sed -i 's/ngs_90X_fq$//g' sentieon_cmd_30X90.list

rm -rf sentieon_cmd_10.list sentieon_cmd_20.list sentieon_cmd_30.list

sed -i 's/^/bash  06_sentieon_call_vcf.sh_10X90  /g' sentieon_cmd_10X90.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_20X90  /g' sentieon_cmd_20X90.list
sed -i 's/^/bash  06_sentieon_call_vcf.sh_30X90  /g' sentieon_cmd_30X90.list

# bash sentieon_cmd_10X90.list
# bash sentieon_cmd_20X90.list
# bash sentieon_cmd_30X90.list


