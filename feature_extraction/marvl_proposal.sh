#!/bin/bash

LANG=$1
ROOT="/science/image/nlp-datasets/emanuele/data/marvl"

source activate /science/image/nlp-datasets/emanuele/envs/py-bottomup

python marvl_proposal.py --root $ROOT --lang $LANG

conda deactivate
