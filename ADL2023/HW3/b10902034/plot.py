import numpy as np
import matplotlib.pyplot as plt

x = [1, 2, 3, 4]
y = [3.5957347593307496, 3.4141056122779845, 3.4124814023971557,3.4371703333854677]

plt.plot(x, y, label='Learning Curve')

plt.xlabel('Epoch')
plt.ylabel('Mean Perplexity')
plt.title('Learning Curve Plot')

plt.legend()
plt.savefig('plot.png')
