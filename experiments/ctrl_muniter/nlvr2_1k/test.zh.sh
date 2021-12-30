#!/bin/bash

TASK=12
MODEL=ctrl_muniter
MODEL_CONFIG=ctrl_muniter_base
TASKS_CONFIG=xling_test_nlvr2
TRTASK=NLVR2
TETASK=NLVR2_1k-zh
TEXT_PATH=/home/projects/ku_00062/data/nlvr2-mini/annotations/test_250-zh.jsonl
PRETRAINED=/home/projects/ku_00062/checkpoints/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/pytorch_model_best.bin
OUTPUT_DIR=/home/projects/ku_00062/results/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/$TETASK/test

source /home/projects/ku_00062/envs/marvl/bin/activate

cd ../../../volta
python eval_task.py \
        --bert_model /home/projects/ku_00062/huggingface/bert-base-multilingual-cased \
	--config_file config/${MODEL_CONFIG}.json \
        --from_pretrained ${PRETRAINED} \
        --tasks_config_file config_tasks/${TASKS_CONFIG}.yml --task $TASK \
        --output_dir ${OUTPUT_DIR} --val_annotations_jsonpath ${TEXT_PATH} \

deactivate

