import numpy as np
import matplotlib.pyplot as plt
from PIL import Image

"""
Implementation of Principal Component Analysis.
"""
class PCA:
    def __init__(self, n_components: int) -> None:
        self.n_components = n_components
        self.mean = None
        self.components = None

    def fit(self, X: np.ndarray) -> None:
        #TODO: 10%
        self.mean = np.mean(X, axis=0)
        mean_shifted = X - self.mean
        cov_matrix = np.cov(mean_shifted.T)
        eigenvalues, eigenvectors = np.linalg.eigh(cov_matrix)
        idx = eigenvalues.argsort()[::-1]
        self.components = eigenvectors[:, idx][:, :self.n_components]

        self.draw_face(self.mean, "mean")

        for i in range(4):
            self.draw_face(self.components[:, i], "eigenface " + str(i+1))

    def transform(self, X: np.ndarray) -> np.ndarray:
        #TODO: 2%
        return np.dot(X - self.mean, self.components)

    def reconstruct(self, X):
        #TODO: 2%   
        return np.dot(self.transform(X), self.components.T) + self.mean

# Implement the reconstruct methods for PCA. Transform the given file ./data/subject_05_17.png with PCA and reconstruct the image with PCA. Plot the original image and the reconstructed image.
    def plot(self):
        img = Image.open('./data/subject_05_17.png').convert("L")
        img_array = np.array(img)
        original_vector = img_array.flatten() / 255.0
        reconstructed_vector = self.reconstruct(original_vector)
        reconstructed_vector = reconstructed_vector.reshape(img_array.shape)
        plt.imshow(img_array, cmap='gray')
        plt.title('Original Image of PCA')
        plt.show()
        plt.imshow(reconstructed_vector, cmap='gray')
        plt.title('Reconstructed Image of PCA')
        plt.show()

        mse = ((original_vector - reconstructed_vector.flatten())**2).mean()

        return mse
    
    def draw_face(self, X, title):
        plt.imshow(X.reshape(61, 80), cmap='gray')
        plt.title(title)
        plt.show()
