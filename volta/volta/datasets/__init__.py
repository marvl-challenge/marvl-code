# Copyright (c) Facebook, Inc. and its affiliates.
# Copyright (c) 2020, Emanuele Bugliarello (@e-bug).

# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

from .concept_cap_dataset import ConceptCapLoaderTrain, ConceptCapLoaderVal
from .nlvr2_dataset import NLVR2Dataset
from .wikipedias_dataset import WikipediasDataset
from .marvl_dataset import MaRVLDataset

__all__ = [
    "ConceptCapLoaderTrain",
    "ConceptCapLoaderVal",
    "NLVR2Dataset",
    "WikipediasDataset",
    "MaRVLDataset",
    "",
]

DatasetMapTrain = {
    "NLVR2": NLVR2Dataset,
    "NLVR2zh": NLVR2Dataset,
}

DatasetMapEval = {
    "NLVR2": NLVR2Dataset,
    "NLVR2zh": NLVR2Dataset,
    "MaRVL": MaRVLDataset,
}
