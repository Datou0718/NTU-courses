from transformers import AutoTokenizer
from transformers import AutoModelForSeq2SeqLM
from transformers import GenerationConfig
import json
from tqdm import tqdm
import torch
import argparse

strategies = {
    "greedy": GenerationConfig(max_length=128),
    "beam_2": GenerationConfig(num_beams=2, max_length=128),
    "beam_4": GenerationConfig(num_beams=4, max_length=128),
    "top_k_25": GenerationConfig(do_sample=True, top_k=25, max_length=128),
    "top_k_75": GenerationConfig(do_sample=True, top_k=75, max_length=128),
    "top_p_0.9": GenerationConfig(do_sample=True, top_p=0.9, max_length=128),
    "top_p_0.75": GenerationConfig(do_sample=True, top_p=0.75, max_length=128),
    "temperature_1.5": GenerationConfig(do_sample=True, temperature=1.5),
    "temperature_0.75": GenerationConfig(do_sample=True, temperature=0.75)
}

parser = argparse.ArgumentParser()
parser.add_argument("--input", type=str, help="Path to the input file.")
parser.add_argument("--output", type=str, help="Path to the output file.")
parser.add_argument("--model", type=str, help="Path to model.")
args = parser.parse_args()

tokenizer = AutoTokenizer.from_pretrained(args.model)
model = AutoModelForSeq2SeqLM.from_pretrained(args.model).to("cuda")

with open(args.input, "r") as file:
    ref = json.load(file)

for strategy in ["greedy"]:
    with open(args.output, "w") as f:
        for data in tqdm(ref):
            text = "summarize: " + data["maintext"]
            inputs = tokenizer(text, return_tensors="pt", max_length=2048, truncation=True).input_ids.to("cuda")
            outputs = model.generate(inputs, generation_config=strategies[strategy])
            result = tokenizer.decode(outputs[0], skip_special_tokens=True)
            cat = {"title": result, "id": data["id"]}
            f.write(json.dumps(cat, ensure_ascii=False) + '\n')
