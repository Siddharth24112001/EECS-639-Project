import os
import csv

from typing import Iterable, Union, Dict, List

"""
Splits the user_behavior_dataset by device model into smaller datasets
"""
DATA_SET_NAME = "user_behavior_dataset.csv"
DIR_PATH = os.path.dirname(os.path.abspath(__file__))
ROW = Dict[str, Union[str, int]]


def try_parse_int(value: str) -> Union[str, int]:
    try:
        return int(value)
    except ValueError:
        return value


class SplitDataSet:
    def __init__(self, name: str, columns: Iterable[str]):
        self.name = name
        self.columns = columns
        self.rows: List[ROW] = []

    def add_row(self, row):
        self.rows.append(SplitDataSet.process_row(row))

    @staticmethod
    def process_row(row: Dict[str, str]) -> ROW:
        return {row_name: try_parse_int(value)
                for row_name, value in row.items()}

    def __str__(self):
        return str(self.rows)


def split_dataset(relative_dataset_path: str, split_col: str) -> Dict[str, SplitDataSet]:
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
                split = SplitDataSet(name=row[split_col], columns=[
                    col for col in cols if col != split_col])
                split_items[split_critera] = split

            split.add_row({k: v for k, v in row.items() if k != split_col})
    return split_items


if __name__ == "__main__":
    splits = split_dataset(DATA_SET_NAME, "Device Model")
    for split_name, split in splits.items():
        out_path = os.path.join(
            DIR_PATH, split_name.replace(" ", "_") + ".csv")
        with open(out_path, "w") as output_file:
            field_names = split.columns
            writer = csv.DictWriter(output_file, fieldnames=field_names)
            writer.writeheader()
            writer.writerows(split.rows)
