# coding=utf-8

from detectron2_proposal_maxnms import collate_fn, extract, NUM_OBJECTS, DIM
from torch.utils.data import Dataset, DataLoader
import cv2
from tqdm import tqdm
from pathlib import Path
import argparse


class VLDataset(Dataset):
    def __init__(self, image_dir):
        self.image_dir = image_dir
        self.image_path_list = list(tqdm(image_dir.glob("*/*")))
        self.n_images = len(self.image_path_list)
        print(f"Processing {self.n_images} images...")

    def __len__(self):
        return self.n_images

    def __getitem__(self, idx):
        image_path = self.image_path_list[idx]
        image_id = image_path.stem

        img = cv2.imread(str(image_path))

        return {
            'img_id': image_id,
            'img': img
        }


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('--batchsize', default=1, type=int, help='batch_size')
    parser.add_argument('--root', type=str,
                        default='/data/marvl')
    parser.add_argument('--lang', type=str, default=None)

    args = parser.parse_args()

    dset_dir = Path(args.root).resolve()
    dset_img_dir = dset_dir.joinpath('images').joinpath(args.lang)

    dataset_name = 'MaRVL'

    out_dir = dset_dir.joinpath('features')
    if not out_dir.exists():
        out_dir.mkdir()

    print('Load images from', dset_img_dir)

    dataset = VLDataset(dset_img_dir)

    dataloader = DataLoader(dataset, batch_size=args.batchsize,
                            shuffle=False, collate_fn=collate_fn, num_workers=4)

    output_fname = out_dir.joinpath(f'marvl-{args.lang}_boxes{NUM_OBJECTS}.h5')
    print('features will be saved at', output_fname)

    desc = f'{dataset_name}-{args.lang}_{(NUM_OBJECTS, DIM)}'

    extract(output_fname, dataloader, desc)

