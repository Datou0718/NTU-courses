import json
import argparse
from tw_rouge import get_rouge

def main():
    ref, pred1, pred2, pred3, pred4, pred5 = [], [], [], [], [], []

    with open("../../data/preprocessed/public.json", "r") as file:
        data = json.load(file)
        for segment in data:
            ref.append(segment["title"])

    with open("./4_prediction.json", "r") as file:
        data = json.load(file)
        for segment in data:
            pred1.append(segment["title"])
    with open("./8_prediction.json", "r") as file:
        data = json.load(file)
        for segment in data:
            pred2.append(segment["title"])
    with open("./12_prediction.json", "r") as file:
        data = json.load(file)
        for segment in data:
            pred3.append(segment["title"])
    with open("./16_prediction.json", "r") as file:
        data = json.load(file)
        for segment in data:
            pred4.append(segment["title"])
    with open("./20_prediction.json", "r") as file:
        data = json.load(file)
        for segment in data:
            pred5.append(segment["title"])

    score1 = get_rouge(pred1, ref)
    score2 = get_rouge(pred2, ref)
    score3 = get_rouge(pred3, ref)
    score4 = get_rouge(pred4, ref)
    score5 = get_rouge(pred5, ref)

    rouge1, rouge2, rougel = [], [], []
    rouge1.append(score1["rouge-1"]["f"]*100)
    rouge2.append(score1["rouge-2"]["f"]*100)
    rougel.append(score1["rouge-l"]["f"]*100)
    rouge1.append(score2["rouge-1"]["f"]*100)
    rouge2.append(score2["rouge-2"]["f"]*100)
    rougel.append(score2["rouge-l"]["f"]*100)
    rouge1.append(score3["rouge-1"]["f"]*100)
    rouge2.append(score3["rouge-2"]["f"]*100)
    rougel.append(score3["rouge-l"]["f"]*100)
    rouge1.append(score4["rouge-1"]["f"]*100)
    rouge2.append(score4["rouge-2"]["f"]*100)
    rougel.append(score4["rouge-l"]["f"]*100)
    rouge1.append(score5["rouge-1"]["f"]*100)
    rouge2.append(score5["rouge-2"]["f"]*100)
    rougel.append(score5["rouge-l"]["f"]*100)

    with open( "./rouge1.json", "w") as f:
        json.dump(rouge1, f)
    with open( "./rouge2.json", "w") as f:
        json.dump(rouge2, f)
    with open( "./rougel.json", "w") as f:
        json.dump(rougel, f)


if __name__ == '__main__':
    main()
