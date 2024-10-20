# !/bin/bash

pip install stylegan2_pytorch
stylegan2_pytorch --data ./faces --image-size 64 --num-train-steps 30000
mkdir images
python generate.py