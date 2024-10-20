import json
import argparse

def parse_args():
    parser = argparse.ArgumentParser(description="preprocess data for multiple choice task.")
    parser.add_argument(
        "--data_type",
        type=str,
        default=None,
        help="Type of the raw data(test/train/valid).",
    )
    parser.add_argument(
        "--model_type",
        type=str,
        default=None,
        help="preprocess for MC or QA or end2end.",
    )
    args = parser.parse_args()

    return args

def convert_data_format_for_MC(data, context_data):
    converted_data = {}
    converted_data['ending0'] = context_data[data['paragraphs'][0]]
    converted_data['ending1'] = context_data[data['paragraphs'][1]]
    converted_data['ending2'] = context_data[data['paragraphs'][2]]
    converted_data['ending3'] = context_data[data['paragraphs'][3]]
    converted_data['label'] = data['paragraphs'].index(data['relevant'])
    converted_data['sent1'] = data['question']
    converted_data['sent2'] = ""
    converted_data['id'] = data['id']
    return converted_data

def convert_data_format_for_QA(data, context_data):
    converted_data = {}
    converted_data['question'] = data['question']
    converted_data['context'] = context_data[data['relevant']]
    converted_data['id'] = data['id']
    converted_data['answers'] = {
        'answer_start': [data['answer']['start']],
        'text': [data['answer']['text']]
    }
    return converted_data

def convert_data_format_for_test_MC(data, context_data):
    converted_data = {}
    converted_data['ending0'] = context_data[data['paragraphs'][0]]
    converted_data['ending1'] = context_data[data['paragraphs'][1]]
    converted_data['ending2'] = context_data[data['paragraphs'][2]]
    converted_data['ending3'] = context_data[data['paragraphs'][3]]
    converted_data['label'] = "0"
    converted_data['sent1'] = data['question']
    converted_data['sent2'] = ""
    converted_data['id'] = data['id']
    return converted_data

def convert_data_format_for_test_QA(data, context_data, label):
    converted_data = {}
    converted_data['question'] = data['question']
    converted_data['context'] = context_data[data['paragraphs'][label]]
    converted_data['id'] = data['id']
    return converted_data

def end2end(data, context_data):
    converted_data = {}
    converted_data['question'] = data['question']
    converted_data['context'] = context_data[data['paragraphs'][0]] + context_data[data['paragraphs'][1]] + context_data[data['paragraphs'][2]] + context_data[data['paragraphs'][3]]
    converted_data['id'] = data['id']
    length = 0
    for i in range(data['paragraphs'].index(data['relevant'])):
        length += len(context_data[data['paragraphs'][i]])
    converted_data['answers'] = {
        'answer_start': [data['answer']['start'] + length],
        'text': [data['answer']['text']]
    }
    return converted_data

def end2end_test(data, context_data):
    converted_data = {}
    converted_data['question'] = data['question']
    converted_data['context'] = context_data[data['paragraphs'][0]] + context_data[data['paragraphs'][1]] + context_data[data['paragraphs'][2]] + context_data[data['paragraphs'][3]]
    converted_data['id'] = data['id']
    return converted_data

def main():
    args = parse_args()

    file_path = "../raw_data/" + args.data_type + ".json"
    context_path = '../raw_data/context.json'
    dest_path = args.data_type + "_" + args.model_type + ".json"
    label_path = "../../inference/MC_inference.json"

    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    with open(context_path, 'r', encoding='utf-8') as c:
        context_data = json.load(c)

    converted_data_list = []
    if args.data_type == 'test':
        if args.model_type == 'MC':
            for item in data:
                converted_data_list.append(convert_data_format_for_test_MC(item, context_data))
        elif args.model_type == 'QA':
            cnt = 0
            with open(label_path, 'r', encoding='utf-8') as d:
                label_data = json.load(d)
            for item in data:
                converted_data_list.append(convert_data_format_for_test_QA(item, context_data, label_data[cnt]))
                cnt += 1
            converted_data_list = {"data": converted_data_list}
        else:
            for item in data:
                converted_data_list.append(end2end_test(item, context_data))
            converted_data_list = {"data": converted_data_list}

    else:
        if args.model_type == 'MC':
            for item in data:
                converted_data_list.append(convert_data_format_for_MC(item, context_data))
        elif args.model_type == 'QA':
            for item in data:
                converted_data_list.append(convert_data_format_for_QA(item, context_data))
            converted_data_list = {"data": converted_data_list}
        else:
            for item in data:
                converted_data_list.append(end2end(item, context_data))
            converted_data_list = {"data": converted_data_list}

    with open(dest_path, 'w', encoding='utf-8') as d:
        json.dump(converted_data_list, d, ensure_ascii=False)

if __name__ == "__main__":
    main()
