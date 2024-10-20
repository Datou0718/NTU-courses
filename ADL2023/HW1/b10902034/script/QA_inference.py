import csv
import json
import pandas as pd
from collections import Counter
from transformers import pipeline

# for single inference
# model = "../model/QA/chinese-roberta-wwm-ext_20"
# question_answerer = pipeline("question-answering", model=model, device='cuda')

# for polling inference

model1 = "../submit_model/QA/roberta_718"  
model2 = "../submit_model/QA/2023-10-18_12:53:18" # large 83.748, batch=32(?), epoch=20
model3 = "../submit_model/QA/roberta_821"
model4 = "../submit_model/QA/2023-10-17_14:23:01" # large 83.848

question_answerer1 = pipeline("question-answering", model=model1, device='cuda')
question_answerer2 = pipeline("question-answering", model=model2, device='cuda')
question_answerer3 = pipeline("question-answering", model=model3, device='cuda')
question_answerer4 = pipeline("question-answering", model=model4, device='cuda')

def remove_unwanted_symbols(answer):
    if answer.startswith(('「')):
        answer = answer[1:]
    while answer.endswith(('。', '」')):
        answer = answer[:-1]
    return answer

def polling(question, context):
    answers = []

    answer1 = question_answerer1(question=question, context=context)
    answer2 = question_answerer2(question=question, context=context)
    answer3 = question_answerer3(question=question, context=context)
    answer4 = question_answerer4(question=question, context=context)

    answers.extend([answer1['answer'], answer2['answer'], answer3['answer'], answer4['answer']])

    answer_counter = Counter(answers)
    most_common_answer, most_common_count = answer_counter.most_common(1)[0]

    if answer_counter[answer2['answer']] == most_common_count:
        return remove_unwanted_symbols(answer2['answer'])
    else:
        return remove_unwanted_symbols(most_common_answer)

file_path = "../dataset/preprocessed/test_QA.json"
with open(file_path, 'r', encoding='utf-8') as f:
    data = json.load(f)

predicted_list = []
id_list = []

for item in data["data"]: 
    question = item['question']
    context = item['context']
    id_list.append(item['id'])

    # for polling inference
    result = polling(question=question, context=context)

    # for single inference
    # result = question_answerer(question=question, context=context)
    # result = result['answer']

    predicted_list.append(result)

inference_path = "./prediction.csv"
df = pd.DataFrame({'id': id_list, 'answer': predicted_list})
df.to_csv(inference_path, index=False)
