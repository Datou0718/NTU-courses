import json
import matplotlib.pyplot as plt

file_names = ['rouge1.json', 'rouge2.json', 'rougel.json']
data = {file_name: {} for file_name in file_names}

for file_name in file_names:
    with open(file_name, 'r') as f:
        data[file_name] = json.load(f)

x = [4, 8, 12, 16, 20]
y_values = {file_name: [data[file_name][i] for i in range(5)] for file_name in file_names}

plt.figure(figsize=(10, 6))

plt.plot(x, y_values["rouge1.json"], marker='o', label="rouge1")
plt.plot(x, y_values["rouge2.json"], marker='o', label="rouge2")
plt.plot(x, y_values["rougel.json"], marker='o', label="rougel")

plt.xlabel('Epoch')
plt.ylabel('Rouge Score')
plt.title('Plot of Learning Curve')
plt.xticks(x)
plt.legend()
plt.grid(True)
plt.savefig('plot.png')
plt.show()
