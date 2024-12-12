import os
import csv

from typing import Optional, Iterable, Union, Dict, List

"""
Splits the user_behavior_dataset by device model into smaller datasets
"""
DATA_SET_NAME = "user_behavior_dataset.csv"
DIR_PATH = os.path.dirname(os.path.abspath(__file__))
DATA_PATH = os.path.join(DIR_PATH, 'device_model')

ROW = Dict[str, Union[str, int]]

SPLIT_COL = "Device Model"
OUTPUT_COL = 'Battery Drain (mAh/day)'
INPUT_COLS = ["App Usage Time (min/day)", "Screen On Time (hours/day)"]

DIR_MAPPING = {
    k: "_".join(map(lambda string: string.lower(), filter(lambda string: string[0] != "(", k.split(' ')))) for k in INPUT_COLS
}


def try_parse_float(value: str) -> Union[str, float]:
    try:
        return float(value)
    except ValueError:
        return value


class SplitDataSet:
    def __init__(self, name: str, columns: Iterable[str], input_col: str):
        self.name = name
        self.columns = columns
        self.input_col = input_col
        self.rows: List[ROW] = []
        self.highest_out = -999

    def add_row(self, row):
        row = self.process_row(row)
        if not row is None:
            self.rows.append(row)

    def process_row(self, row: Dict[str, str]) -> Optional[ROW]:
        parsed = {row_name: try_parse_float(value)
                  for row_name, value in row.items()}

        for row_idx, row in enumerate(self.rows):
            if len(self.rows) == 0:
                break
            if parsed[self.input_col] != row[self.input_col]:
                continue

            if parsed[OUTPUT_COL] > row[OUTPUT_COL]:
                self.rows.pop(row_idx)
            else:
                return None

        return parsed

    def __str__(self):
        return str(self.rows)


def split_dataset(relative_dataset_path: str, split_col: str, input_col: str) -> Dict[str, SplitDataSet]:
    data_set_path = os.path.join(DIR_PATH, relative_dataset_path)
    split_items: Dict[str, SplitDataSet] = {}
    with open(data_set_path) as data_set:
        reader = csv.DictReader(data_set)
        cols = reader.fieldnames
        assert split_col in cols, f"Column {split_col} not in {cols}"
        for row in reader:
            split_critera = row[split_col]
            if split_critera in split_items:
                split = split_items.get(split_critera)
            else:
                split = SplitDataSet(name=row[split_col], input_col=input_col, columns=[
                    col for col in cols if col != split_col])
                split_items[split_critera] = split

            split.add_row({k: v for k, v in row.items() if k != split_col})
    return split_items


def write_split_dataset(relative_dataset_path: str, split_col: str, input_col: str):
    splits = split_dataset(relative_dataset_path, split_col, input_col)
    data_dir = os.path.join(DATA_PATH, DIR_MAPPING[input_col])
    for split_name, split in splits.items():
        out_path = os.path.join(
            data_dir, split_name.replace(" ", "_") + ".csv")
        with open(out_path, "w") as output_file:
            field_names = split.columns
            writer = csv.DictWriter(output_file, fieldnames=field_names)
            writer.writeheader()
            writer.writerows(
                sorted(split.rows, key=lambda row: row[input_col]))


if __name__ == "__main__":
    for col in INPUT_COLS:
        write_split_dataset(DATA_SET_NAME, SPLIT_COL, col)
