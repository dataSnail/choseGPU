
#!/bin/bash
n=$(nvidia-smi -q -d Memory|grep -A4 GPU|grep Free |grep -Eo "[0-9]+"|awk '{{printf"%s,",$0}}')
OLD_IFS="$IFS"
IFS=","
n_list=($n)
IFS="$OLD_IFS"

max=${n_list[0]}
max_id=0

for var in ${!n_list[@]}
do
    if [[ ${max} -le ${n_list[$var]} ]];then
    max_id=${var}
    max=${n_list[${var}]}
    echo "gpu $max_id: $max MiB"
    fi
done
echo "finally chose gpu $max_id, reamain memory $max MiB"

# run your command
#python main.py --gpu_id $max_id