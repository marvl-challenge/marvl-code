# MaRVL

This is the implementation of the approaches described in the paper:

> Fangyu Liu*, Emanuele Bugliarello*, Edoardo M. Ponti, Siva Reddy, Nigel Collier and Desmond Elliott. [Visually Grounded Reasoning over Languages and Cultures](https://arxiv.org/abs/2109.13238). In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing (EMNLP), Nov 2021.

We provide the pretrained models, data and the code for reproducing our results.

The code will also be integrated into [VOLTA](https://github.com/e-bug/volta), upon which our repository was origally built.


## Repository Setup

You can clone this repository issuing: <br>
`git clone git@github.com:marvl-challenge/marvl-code`

1\. Create create a new virtual environment:
```text
python3 -m venv /path/to/new/virtual/environment/marvl
source /path/to/new/virtual/environment/marvl/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

2\. Install [apex](https://github.com/NVIDIA/apex). For example by issuing:
```text
cd volta/apex
pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./
```
If you use a cluster, you may want to first run commands like the following:
```text
module load cuda/10.1.105
module load gcc/8.3.0-cuda
```

3\. Setup the `refer` submodule for Referring Expression Comprehension:
```
cd volta/tools/refer; make
deactivate
```


## Data

We distribute the texts and features under the [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/deed.ast).

Text data (original and machine translations) is available under [`data/`](data).

Preprocessed visual features can be downloaded from [ERDA](https://sid.erda.dk/sharelink/hmoEs4a3oG).
You will need to convert these H5 files into LMDB format by:
```text
cd feature_extraction
bash h5_to_lmdb.sh
```

The feature extraction process can be replicated by running (`bash marvl_proposal.sh`).
It is based on Hao Tan's [Bottom-up Attention with Detectron2](https://github.com/airsplay/py-bottom-up-attention).

The MaRVL team does not own the images and we provide access to the images only for (non-commercial) research purposes.
They can be download from the [Dataverse portal](https://dataverse.scholarsportal.info/dataset.xhtml?persistentId=doi:10.5683/SP3/42VZ4P).


## Models

Pretrained mUNITER and xUNITER can be downloaded from [ERDA](https://sid.erda.dk/sharelink/HfTaLDBWJi).

Model configuration files are stored in [volta/config/](config).

These models were trained with the same hyperparameters and multimodal data as the controlled models in VOLTA.
They, however, also use text-only Wikipedia data in [104 languages](https://github.com/google-research/bert/blob/master/multilingual.md#list-of-languages) during pretraining. We used the [Plaintext Wikipedia dump 2018](https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-2735).


## Training and Evaluation

We provide sample scripts to train (i.e. pretrain or fine-tune) and evaluate models in [experiments/](experiments).

Task configuration files are stored in [volta/config_tasks/](volta/config_tasks).

Analyses and results can be found under [notebooks/](notebooks).


## License

We distribute the texts and features under the [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/deed.ast).

This work is licensed under the MIT license. See [`LICENSE`](LICENSE) for details. 
Third-party software and data sets are subject to their respective licenses. <br>
If you find our code/data/models or ideas useful in your research, please consider citing the paper:
```
@inproceedings{liu-etal-2021-visually,
    title = "Visually Grounded Reasoning across Languages and Cultures",
    author = "Liu, Fangyu  and
      Bugliarello, Emanuele  and
      Ponti, Edoardo Maria  and
      Reddy, Siva  and
      Collier, Nigel  and
      Elliott, Desmond",
    booktitle = "Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing",
    month = nov,
    year = "2021",
    address = "Online and Punta Cana, Dominican Republic",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2021.emnlp-main.818",
    pages = "10467--10485",
}
