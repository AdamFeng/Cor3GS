#!/bin/bash
ls split_fq_10X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " split_fa_10X/"$2}' > cmd.list
sed 's/^/python fq2fa.py /g' cmd.list > cmd_10X.list


ls split_fq_20X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " split_fa_20X/"$2}' > cmd.list
sed 's/^/python fq2fa.py /g' cmd.list > cmd_20X.list


ls split_fq_30X/* > fq.list
cat fq.list | awk 'BEGIN {FS="/"} {print $0 " split_fa_30X/"$2}' > cmd.list
sed 's/^/python fq2fa.py /g' cmd.list > cmd_30X.list

bash cmd_10X.list
bash cmd_20X.list
bash cmd_30X.list