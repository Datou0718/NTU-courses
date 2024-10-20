import argparse
import json
import logging
import math
import os
import random
from dataclasses import dataclass
from itertools import chain
from pathlib import Path
from typing import Optional, Union

import datasets
import evaluate
import torch
from accelerate import Accelerator
from accelerate.logging import get_logger
from accelerate.utils import set_seed
from datasets import load_dataset
from huggingface_hub import Repository, create_repo
from torch.utils.data import DataLoader
from tqdm.auto import tqdm

import transformers
from transformers import (
    CONFIG_MAPPING,
    MODEL_MAPPING,
    AutoConfig,
    AutoModelForMultipleChoice,
    AutoTokenizer,
    PreTrainedTokenizerBase,
    SchedulerType,
    default_data_collator,
    get_scheduler,
)
from transformers.utils import PaddingStrategy, check_min_version, send_example_telemetry

pretrained_model = "../submit_model/MC/roberta_5"
tokenizer = AutoTokenizer.from_pretrained(pretrained_model)
model = AutoModelForMultipleChoice.from_pretrained(pretrained_model)

file_path = "../dataset/preprocessed/test_MC.json"

data_files = {}
data_files["eval"] = file_path
extension = 'json'
raw_datasets = load_dataset(extension, data_files=data_files)
column_names = raw_datasets["eval"].column_names


ending_names = [f"ending{i}" for i in range(4)]
context_name = "sent1"
question_header_name = "sent2"
label_column_name = "label" if "label" in column_names else "labels"

def preprocess_function(examples):
    first_sentences = [[context] * 4 for context in examples[context_name]]
    question_headers = examples[question_header_name]
    second_sentences = [
        [f"{header} {examples[end][i]}" for end in ending_names] for i, header in enumerate(question_headers)
    ]
    labels = examples[label_column_name]

    # Flatten out
    first_sentences = list(chain(*first_sentences))
    second_sentences = list(chain(*second_sentences))

    # Tokenize
    tokenized_examples = tokenizer(
        first_sentences,
        second_sentences,
        max_length=512,
        padding=True,
        truncation=True,
    )
    # Un-flatten
    tokenized_inputs = {k: [v[i : i + 4] for i in range(0, len(v), 4)] for k, v in tokenized_examples.items()}
    tokenized_inputs["labels"] = labels
    return tokenized_inputs

accelerator_log_kwargs = {}
accelerator = Accelerator(gradient_accumulation_steps=1, **accelerator_log_kwargs)

with accelerator.main_process_first():
    processed_datasets = raw_datasets.map(
        preprocess_function, batched=True, remove_columns=raw_datasets["eval"].column_names
    )

eval_dataset = processed_datasets["eval"]

predicted_list = []

eval_dataloader = DataLoader(eval_dataset, collate_fn=default_data_collator, batch_size=8)

model, eval_dataloader = accelerator.prepare(model, eval_dataloader)

model.eval()

for step, batch in enumerate(eval_dataloader):
    with torch.no_grad():
        outputs = model(**batch)
    predictions = outputs.logits.argmax(dim=-1)
    predicted_list.extend(predictions.tolist())
inference_path = "./MC_inference.json"
with open(inference_path, 'w', encoding='utf-8') as d:
    json.dump(predicted_list, d, ensure_ascii=True)
