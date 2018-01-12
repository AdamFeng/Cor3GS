#!/bin/bash
ls sam_file_10X/* > sam.list
sed 's/^/python cal_error_rate.py /g' sam.list > cmd_sam_10X.list
sed -i 's/$/ >> error_10X.txt/g' cmd_sam_10X.list


ls sam_file_20X/* > sam.list
sed 's/^/python cal_error_rate.py /g' sam.list > cmd_sam_20X.list
sed -i 's/$/ >> error_20X.txt/g' cmd_sam_20X.list


ls sam_file_30X/* > sam.list
sed 's/^/python cal_error_rate.py /g' sam.list > cmd_sam_30X.list
sed -i 's/$/ >> error_30X.txt/g' cmd_sam_30X.list

bash cmd_sam_10X.list
bash cmd_sam_20X.list
bash cmd_sam_30X.list