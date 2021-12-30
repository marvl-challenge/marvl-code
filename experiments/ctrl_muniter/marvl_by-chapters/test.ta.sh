#!/bin/bash

lang=ta
TASK=12
MODEL=ctrl_muniter
MODEL_CONFIG=ctrl_muniter_base
TRTASK=NLVR2
TETASK=MaRVL${lang}
TASKS_CONFIG=xling_test_marvl
FEAT_PATH=/home/projects/ku_00062/data/marvl/features/marvl-${lang}_boxes36.lmdb
PRETRAINED=/home/projects/ku_00062/checkpoints/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/pytorch_model_best.bin

source /home/projects/ku_00062/envs/marvl/bin/activate

here=$(pwd)
cd ../../../volta
for cat in 10 14 17 18 19 3 5 6 7 8 9; do 
  TEXT_PATH=/home/projects/ku_00062/data/marvl/annotations_by_chapter/${lang}/cat-${cat}.json
  OUTPUT_DIR=/home/projects/ku_00062/results/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/$TETASK/test_cat-${cat}
  python eval_task.py \
        --bert_model /home/projects/ku_00062/huggingface/bert-base-multilingual-cased \
        --config_file config/${MODEL_CONFIG}.json \
        --from_pretrained ${PRETRAINED} \
        --val_annotations_jsonpath ${TEXT_PATH} --val_features_lmdbpath ${FEAT_PATH} \
        --tasks_config_file config_tasks/${TASKS_CONFIG}.yml --task $TASK --split test \
        --output_dir ${OUTPUT_DIR} &> $here/test.${lang}.cat-${cat}.log
done

deactivate
