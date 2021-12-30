#!/bin/bash

TASK=12
MODEL=ctrl_muniter
MODEL_CONFIG=ctrl_muniter_base
TASKS_CONFIG=xling_trainval_nlvr2zh
PRETRAINED=/home/projects/ku_00062/checkpoints/marvl/${MODEL}/conceptual_captions_wikipedia/${MODEL_CONFIG}/pytorch_model_9.bin
OUTPUT_DIR=/home/projects/ku_00062/checkpoints/marvl/${MODEL}
LOGGING_DIR=/home/projects/ku_00062/logs/marvl/${MODEL_CONFIG}

source /home/projects/ku_00062/envs/marvl/bin/activate

cd ../../../volta
python train_task.py \
        --bert_model /home/projects/ku_00062/huggingface/bert-base-multilingual-cased --config_file config/${MODEL_CONFIG}.json \
        --from_pretrained ${PRETRAINED} \
        --tasks_config_file config_tasks/${TASKS_CONFIG}.yml --task $TASK --gradient_accumulation_steps 2 \
        --adam_epsilon 1e-6 --adam_betas 0.9 0.999 --adam_correct_bias --weight_decay 0.0001 --warmup_proportion 0.1 --clip_grad_norm 1.0 \
        --output_dir ${OUTPUT_DIR} \
	--logdir ${LOGGING_DIR} \

deactivate
