#!/bin/sh

for packer in pelock pecompact obsidium petite telock themida-v2 mpress kkrunchy upx
do
    echo PACKER $packer
    python training.py config_exp-singlepacker $1 lab-v3 $packer
    echo DONE WITH TRAINING/TESTING of $packer
done
packer=dolphin-dropper-3
echo PACKER $packer
python training.py config_exp-singlepacker $1 lab-dropper $packer
echo DONE WITH TRAINING/TESTING of $packer

cd ../results/
for packer in pelock pecompact obsidium petite telock themida-v2 mpress kkrunchy upx
do
    echo PACKER $packer
    respath=../../results/paper/experiments/exp-singlePacker/$1/lab-v3/$packer/dll-generic-header-import-ngrams-opcodes-rich-sections-strings/
    db=$respath/exp.db
    json=$db.json
    csv=$db.csv
    python process_sql.py $db
    python add_metrics_csv.py $csv $csv
    python metrics.py $json
    python top_features.py $json 50
    echo DONE WITH ANALYZING results of $packer
done

packer=dolphin-dropper-3
echo PACKER $packer
respath=../../results/paper/experiments/exp-singlePacker/$1/lab-dropper/$packer/dll-generic-header-import-ngrams-opcodes-rich-sections-strings/
db=$respath/exp.db
json=$db.json
csv=$db.csv
python process_sql.py $db
python add_metrics_csv.py $csv $csv
python metrics.py $json
python top_features.py $json 50
echo DONE WITH ANALYZING results of $packer

cd $(dirname "$0")
