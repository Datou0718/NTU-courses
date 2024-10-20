import torch
from tqdm import tqdm
from transformers import AutoModelForCausalLM, AutoTokenizer
import json
from peft import PeftModel
from utils import get_bnb_config, get_prompt
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--base_model_path",
        type=str,
        default="",
        help="Path to the checkpoint of Taiwan-LLM-7B-v2.0-chat. If not set, this script will use "
        "the checkpoint from Huggingface (revision = 5073b2bbc1aa5519acdc865e99832857ef47f7c9)."
    )
    parser.add_argument(
        "--peft_path",
        type=str,
        required=True,
        help="Path to the saved PEFT checkpoint."
    )
    parser.add_argument(
        "--test_data_path",
        type=str,
        default="",
        required=True,
        help="Path to test data."
    )
    parser.add_argument(
        "--output_path",
        type=str,
        default="",
        required=True,
        help="Path for output json."
    )
    args = parser.parse_args()

    bnb_config = get_bnb_config()

    if args.base_model_path:
        model = AutoModelForCausalLM.from_pretrained(
            args.base_model_path,
            torch_dtype=torch.bfloat16,
            quantization_config=bnb_config
        )
        tokenizer = AutoTokenizer.from_pretrained(args.base_model_path, padding_side='left')
    else:
        model_name = "yentinglin/Taiwan-LLM-7B-v2.0-chat"
        revision = "5073b2bbc1aa5519acdc865e99832857ef47f7c9"
        model = AutoModelForCausalLM.from_pretrained(
            model_name,
            revision=revision,
            torch_dtype=torch.bfloat16,
            quantization_config=bnb_config
        )
        tokenizer = AutoTokenizer.from_pretrained(
            model_name,
            padding_side='left',
        )

    if tokenizer.pad_token_id is None:
        tokenizer.pad_token_id = tokenizer.eos_token_id

    # Load LoRA
    model = PeftModel.from_pretrained(model, args.peft_path).to("cuda")

    with open(args.test_data_path, "r") as f:
        data = json.load(f)

    model.eval()

    data_size = len(data)
    instructions = [get_prompt(x["instruction"]) for x in data]
    ids = [x["id"] for x in data]  

    tokenized_instructions = tokenizer(instructions, return_tensors="pt", padding=True, truncation=True, max_length=2048)
    output_masks = []

    predictions = []

    for i in tqdm(range(data_size)):
        input_ids = tokenized_instructions["input_ids"][i].unsqueeze(0).to("cuda")
        attn_mask = tokenized_instructions["attention_mask"][i].unsqueeze(0).to("cuda")
        label = input_ids

        with torch.no_grad():
            output_ids = model.generate(input_ids=input_ids, max_new_tokens=2048, num_return_sequences=1)
        generated_output = tokenizer.decode(output_ids[0], skip_special_tokens=True)[len(instructions[i]):].strip()

        prediction = {
            "id": ids[i],
            "output": generated_output
        }
        predictions.append(prediction)

    with open(args.output_path, "w", encoding='utf-8') as json_file:
        json.dump(predictions, json_file, indent=2, ensure_ascii=False)
