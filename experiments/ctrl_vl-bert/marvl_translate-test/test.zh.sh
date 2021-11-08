#!/bin/bash

TASK=12
MODEL=ctrl_vl-bert
MODEL_CONFIG=ctrl_vl-bert_base
TASKS_CONFIG=ctrl_test_marvl
TRTASK=NLVR2
TETASK=MaRVLzh
TEXT_PATH=/home/projects/ku_00062/data/marvl/annotations_machine-translate/marvl-zh_gmt.jsonl
FEAT_PATH=/home/projects/ku_00062/data/marvl/features/marvl-zh_boxes36.lmdb
PRETRAINED=/home/projects/ku_00062/checkpoints/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/pytorch_model_best.bin
OUTPUT_DIR=/home/projects/ku_00062/results/marvl/${MODEL}/${TRTASK}_${MODEL_CONFIG}/$TETASK-en_mt/test

source /home/projects/ku_00062/envs/mlvr/bin/activate

cd ../../../volta
python eval_task.py \
        --bert_model /home/projects/ku_00062/huggingface/bert-base-uncased \
	--config_file config/${MODEL_CONFIG}.json \
        --from_pretrained ${PRETRAINED} --do_lower_case \
        --val_annotations_jsonpath ${TEXT_PATH} --val_features_lmdbpath ${FEAT_PATH} \
        --tasks_config_file config_tasks/${TASKS_CONFIG}.yml --task $TASK --split test \
        --output_dir ${OUTPUT_DIR} \

deactivate