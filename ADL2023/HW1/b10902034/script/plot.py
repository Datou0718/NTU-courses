import json
import matplotlib.pyplot as plt

with open('./model/QA/roberta_821/curves.json', 'r') as file:
    data = json.load(file)

loss_data = data['Loss']
exact_match_data = [item['exact_match'] for item in data['EM']]

plt.figure(figsize=(10, 5))

plt.subplot(1, 2, 1)
plt.plot(range(1, 11), loss_data, marker='o', linestyle='--', color='b')
plt.title('Loss Curve')
plt.xlabel('Epoch')
plt.ylabel('Loss')

plt.subplot(1, 2, 2)
plt.plot(range(1, 11), exact_match_data, marker='o', linestyle='--', color='r')
plt.title('Exact Match Metric Value Curve')
plt.xlabel('Epoch')
plt.ylabel('Exact Match Metric Value')

plt.tight_layout()
plt.show()
