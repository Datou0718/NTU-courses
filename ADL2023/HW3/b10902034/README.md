# ADL2023 Homework 3

#### Warning: For all the files in this folder, you may need to modify the datapath in the code before you executing them.

## Setup Environment
I use axolotl for training in this homework, so you should clone the github first and follow the instructions (https://github.com/OpenAccess-AI-Collective/axolotl).

## Training
You may need to modify the file `qlora.yml` first, then
`accelerate launch -m axolotl.cli.train qlora.yml`

## Inference
You may need to modify the file `predict.sh` first, then `./predict.sh`.

