import json
import argparse
from tw_rouge import get_rouge

def main(args):
    refs, preds = [], []

    with open(args.reference, "r") as file:
        for line in file:
            data = json.loads(line)
            refs.append(data["title"])

    with open(args.submission, "r") as file:
        for line in file:
            data = json.loads(line)
            preds.append(data["title"])

    score = get_rouge(preds, refs)
    output = []
    output.append({"rouge_1": score["rouge-1"]["f"]*100, "rouge_2": score["rouge-2"]["f"]*100, "rouge_L": score["rouge-l"]["f"]*100})
    print(output)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-r', '--reference')
    parser.add_argument('-s', '--submission')
    args = parser.parse_args()
    main(args)
