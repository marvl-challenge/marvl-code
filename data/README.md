# marvl-data
Data introduced in "Visually Grounded Reasoning across Languages and Cultures", EMNLP 2021.


## Version history

| Version      | Description         |
| ------------ | ------------------- |
| 2021.09      | v1.0       |


## Terms of Use
We distribute the texts and features under the [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/). The MaRVL team does not own the images and we provide access to the images only for (non-commercial) research purposes. You should only use the images under the regulations of their original license(s) and respect the corresponding intellectual property rights. By downloading any of the data, you accept our terms of use and full responsibility for using the dataset. If you believe any of the image(s) we provide has breached your rights please contact us and we will remove the image(s).

Images and descriptions can be downloaded from the [Dataverse portal](https://dataverse.scholarsportal.info/dataset.xhtml?persistentId=doi:10.5683/SP3/42VZ4P).
Extracted image features can be download from [ERDA](https://sid.erda.dk/sharelink/hmoEs4a3oG).

## Introduction

**M**ulticultural **R**easoning over **V**ision and **L**anguage (MaRVL) is a dataset based on an ImageNet-style hierarchy representative of many languages and cultures (Indonesian, Mandarin Chinese, Swahili, Tamil, and Turkish). The selection of both concepts and images is entirely driven by native speakers. Afterwards, we elicit statements from native speakers about pairs of images. The task consists in discriminating whether each grounded statement is true or false. The present file contains all the dataset images and annotations.

Please refer to the paper below for a more detailed description of the dataset.


## Citation

Please cite the following paper if you use this dataset in your work:

Liu, Fangyu, Emanuele Bugliarello, Edoardo Maria Ponti, Siva Reddy, Nigel Collier, and Desmond Elliott. **Visually Grounded Reasoning across Languages and Cultures.** In Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing. 2021.

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
    pages = "10467--10485"
}
```
## Disclaimer

The MaRVL dataset is provided as is. 
As the dataset is annotated by members of different cultures, it may contain language and images that are offensive to some users. 
While these are kept to a minimal, they inevitably exist.


## Content

The directory structure looks as follows:

```
+--- marvl-annotations
|   +--- marvl-$LANGUAGE.jsonl
+--- marvl-images
|    +--- $LANGUAGE
|    |    +--- extra
|    |    +--- images
|    |    +--- name2link.csv
+--- marvl-features
|    +--- $LANGUAGE
|    |    +--- resnet101_faster_rcnn_genome_imgfeats
```

`$LANGUAGE` represents the following values:
| code | name |
|--|--|
| id | Indonesian |
| sw | Swahili |
| ta | Tamil |
| tr | Turkish |
| zh | Mandarin Chinese |
 
 ### `marvl-annotations`
Each file `marvl-$LANGUAGE.jsonl` contains annotations for a specific language, one example per line. 

For instance, it can be easily loaded in Python as follows:

```python 3
import json
data = {}
languages = ['id', 'sw', 'ta', 'tr', 'zh']
for language in languages:
	filepath = f"marvl-annotations/marvl-{language}.jsonl"
	with open(filepath) as f:
	    data[language] = [json.loads(line) for line in f]
```

Each example is a dictionary with the following structure:

| key | type | notes |
|--|--|--|
| concept | str | Language-specific concept `concept_number`-`concept_name` |
| language | str | Language code |
| caption | str | Textual description of a pair of images |
| left_img | str | id of the left image `concept_number`-`image_number`.jpg |
| right_img | str | id of the right image `concept_number`-`image_number`.jpg |
| annotator_info | dict | Additional information about the annotator with keys `annotator_id`, `country_of_birth`, `country_of_residence`, `gender`, `age` |
| chapter | str | Name of the Intercontinental Dictionary Series chapter |
| id | str | Example id `language`-`example_number`|
| label | bool | `true` or `false` |

 ### `marvl-images`

This folder contains subfolders dedicated to each `$LANGUAGE`. Each subfolder contains:

 - `extra`: images collected but not used for the annotation. They can be ignored for the grounded reasoning task.
 - `images`: images used for the annotation.
 - `name2link.csv`: tab-separated metadata specifying the URL from which each image is obtained.

`images` contains a subfolder for each `concept`, which contains `jpg` image files. The path of an image from the root looks like:

`marvl-images/$LANGUAGE/images/$CONCEPT/$IMG`

where `$IMG` is the value in `img_left` or `img_right` in the examples.

### `marvl-features`

This folder contains subfolders dedicated to each `$LANGUAGE`. Each subfolder contains a folder with features extracted using a Faster R-CNN with a ResNet-101 backbone pretrained on Visual Genome ([Anderson et al., 2018](https://arxiv.org/abs/1707.07998)).
