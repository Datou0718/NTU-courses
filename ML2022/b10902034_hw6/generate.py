import torch
import os
from torchvision.utils import save_image
from stylegan2_pytorch import ModelLoader

loader = ModelLoader(
    base_dir = '.',   # path to where you invoked the command line tool
    name = 'default'                   # the project name, defaults to 'default'
)
for i in range(1000):
    noise   = torch.randn(1, 512).cuda() # noise
    styles  = loader.noise_to_styles(noise, trunc_psi = 0.7)  # pass through mapping network
    images  = loader.styles_to_images(styles) # call the generator on intermediate style vectors

    save_image(images, f'./images/{i}.jpg') # save your images, or do whatever you desire
os.system("cd images && tar -zcf ../submission.tgz ./*.jpg")