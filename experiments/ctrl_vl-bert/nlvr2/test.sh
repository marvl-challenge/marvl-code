#!/bin/bash

TASK=12
MODEL=ctrl_vl-bert
MODEL_CONFIG=ctrl_vl-bert_base
TASKS_CONFIG=ctrl_test_nlvr2
TRTASK=NLVR2
TETASK=NLVR2
PRETRAINED=/home/projects/ku_00062/checkpoints/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/pytorch_model_best.bin
OUTPUT_DIR=/home/projects/ku_00062/results/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/$TETASK/test

source /home/projects/ku_00062/envs/marvl/bin/activate

cd ../../../volta
python eval_task.py \
        --bert_model /home/projects/ku_00062/huggingface/bert-base-uncased \
	--config_file config/${MODEL_CONFIG}.json \
        --from_pretrained ${PRETRAINED} --do_lower_case \
        --tasks_config_file config_tasks/${TASKS_CONFIG}.yml --task $TASK \
        --output_dir ${OUTPUT_DIR} \

deactivate

