# Feature extraction

We use [Hao Tan's Detectron2 implementation of 'Bottom-up feature extractor'](https://github.com/airsplay/py-bottom-up-attention), which is compatible with [the original Caffe implementation](https://github.com/peteanderson80/bottom-up-attention).

Following LXMERT, we use the feature extractor which outputs 36 boxes per image.
We store features in hdf5 format.


## Install feature extractor

```bash
conda create -n py-bottomup python=3.6
source activate py-bottomup

cd py-bottom-up-attention

# Install python libraries
pip install -r requirements.txt
pip install 'git+https://github.com/cocodataset/cocoapi.git#subdirectory=PythonAPI'

# Install detectron2
python setup.py build develop

# Download model
mkdir -p $HOME/.torch/fvcore_cache/models/
wget -P $HOME/.torch/fvcore_cache/models/ http://nlp.cs.unc.edu/models/faster_rcnn_from_caffe_attr.pkl

conda deactivate
```

NB:
1. Depending on your system, you might need to re-install PyTorch (e.g. I did `pip install torch==1.4.0+cu92 torchvision==0.5.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html`)
2. The model requires a newer version of gcc -- I load it at KU as shown in `flickr30k_proposal.slurm`
3. I had to also include the lib path (e.g. `LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/pmh864/libs/anaconda3/lib python flickr30k_proposal.py`)

## Extract features
```bash
# Multi30K
# Download images following https://github.com/multi30k/dataset
python flickr30k_proposal.py --split trainval
python flickr30k_proposal.py --split test2017
python flickr30k_proposal.py --split test2018
```
