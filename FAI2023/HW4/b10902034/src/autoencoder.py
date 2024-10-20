import torch
from tqdm.auto import tqdm
import torch.nn as nn
import torch.optim as optim
import matplotlib.pyplot as plt
from PIL import Image
import numpy as np

"""
Implementation of Autoencoder
"""
class Autoencoder(nn.Module):
    def __init__(self, input_dim: int, encoding_dim: int) -> None:
        """
        Modify the model architecture here for comparison
        """
        super(Autoencoder, self).__init__()
        self.encoder = nn.Sequential(
            nn.Linear(input_dim, encoding_dim),
            nn.Linear(encoding_dim, encoding_dim//2),
            nn.ReLU()
        )
        self.decoder = nn.Sequential(
            nn.Linear(encoding_dim//2, encoding_dim),
            nn.Linear(encoding_dim, input_dim),
        )
    
    def forward(self, x):
        #TODO: 5%
        x = self.encoder(x)
        x = self.decoder(x)
        return x
    
    def fit(self, X, epochs=10, batch_size=32):
        #TODO: 5%
        criterion = nn.MSELoss()
        optimizer = optim.Adam(self.parameters(), lr=0.001)

        X = torch.tensor(X, dtype=torch.float32)
        dataloader = torch.utils.data.DataLoader(X, batch_size=batch_size, shuffle=True)

        losses = []
        
        for epoch in tqdm(range(epochs)):
            epoch_loss = 0.0
            for data in dataloader:
                optimizer.zero_grad()
                outputs = self(data)
                loss = criterion(outputs, data)
                loss.backward()
                optimizer.step()
                epoch_loss += loss.item()
            losses.append(epoch_loss)

        plt.plot(range(epochs), losses)
        plt.xlabel('Epochs')
        plt.ylabel('Loss')
        plt.title('Training Loss of AE')
        plt.show()
    
    def transform(self, X):
        #TODO: 2%
        X_tensor = torch.tensor(X, dtype=torch.float32)
        return self.encoder(X_tensor).detach().numpy()
    
    def reconstruct(self, X):
        #TODO: 2%
        return self(X).detach().numpy()
    
    def plot(self):
        img = Image.open('./data/subject_05_17.png').convert("L")
        img_array = np.array(img)
        original_vector = img_array.flatten() / 255.0
        original_vector = torch.tensor(original_vector, dtype=torch.float32)
        reconstructed_vector = self.reconstruct(original_vector)
        reconstructed_vector = reconstructed_vector.reshape(img_array.shape)
        plt.imshow(img_array, cmap='gray')
        plt.title('Original Image of AE')
        plt.show()
        plt.imshow(reconstructed_vector, cmap='gray')
        plt.title('Reconstructed Image of AE')
        plt.show()

        mse = ((original_vector - reconstructed_vector.flatten())**2).mean()

        return mse


"""
Implementation of DenoisingAutoencoder
"""
class DenoisingAutoencoder(Autoencoder):
    def __init__(self, input_dim, encoding_dim, noise_factor=0.2):
        super(DenoisingAutoencoder, self).__init__(input_dim,encoding_dim)
        self.noise_factor = noise_factor

        # self.encoder = nn.Sequential(
        #     nn.Linear(input_dim, encoding_dim),
        #     nn.ReLU(),
        #     nn.Linear(encoding_dim, 2*encoding_dim//3),
        #     nn.ReLU(),
        #     nn.Linear(2*encoding_dim//3, encoding_dim//3),
        #     nn.ReLU()
        # )

        # self.decoder = nn.Sequential(
        #     nn.Linear(encoding_dim//3, 2*encoding_dim//3),
        #     nn.ReLU(),
        #     nn.Linear(2*encoding_dim//3, encoding_dim),
        #     nn.ReLU(),
        #     nn.Linear(encoding_dim, input_dim),
        # )
    
    def add_noise(self, x):
        #TODO: 3%
        noise = torch.randn(x.size()) * self.noise_factor
        return x + noise
    
    def fit(self, X, epochs=10, batch_size=32):
        #TODO: 4%
        criterion = nn.MSELoss()

        optimizer = optim.Adam(self.parameters(), lr=0.001)
        # optimizer = optim.SGD(self.parameters(), lr=0.001, momentum=0.9)
        # optimizer = optim.Nesterov(self.parameters(), lr=0.001, momentum=0.9)


        X = torch.tensor(X, dtype=torch.float32)
        dataloader = torch.utils.data.DataLoader(X, batch_size=batch_size, shuffle=True)

        losses = []

        for epoch in tqdm(range(epochs)):
            epoch_loss = 0.0
            for data in dataloader:
                optimizer.zero_grad()
                noisy_data = self.add_noise(data)
                outputs = self(noisy_data)
                loss = criterion(outputs, data)
                loss.backward()
                optimizer.step()
                epoch_loss += loss.item()
            losses.append(epoch_loss)

        plt.plot(range(epochs), losses)
        plt.xlabel('Epochs')
        plt.ylabel('Loss')
        plt.title('Training Loss of DAE')
        plt.show()
        
    def plot(self):
        img = Image.open('./data/subject_05_17.png').convert("L")
        img_array = np.array(img)
        original_vector = img_array.flatten() / 255.0
        noisy_vector = self.add_noise(torch.tensor(original_vector, dtype=torch.float32)).numpy()
        noisy_vector = torch.tensor(noisy_vector, dtype=torch.float32)
        reconstructed_vector = self.reconstruct(noisy_vector)
        reconstructed_vector = reconstructed_vector.reshape(img_array.shape)
        plt.imshow(img_array, cmap='gray')
        plt.title('Original Image of DAE')
        plt.show()
        plt.imshow(reconstructed_vector, cmap='gray')
        plt.title('Reconstructed Image of DAE')
        plt.show()
        
        mse = ((original_vector - reconstructed_vector.flatten())**2).mean()
        
        return mse
