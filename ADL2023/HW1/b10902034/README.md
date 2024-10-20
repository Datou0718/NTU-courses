# Applied Deep Learning 2023 Homework 1

#### Warning: For all the files in this folder, you may need to modify the datapath in the code before you executing them.

## Setup Environment
To setup environment, you can run
`pip install -r requirements.txt`

## Data Preprocess
The following steps will guide you convert raw data into the format the model want.
1. `cd script`
2. `preprocess.py --data_type=<test/train/valid> --model_type=<MC/QA/end2end>`
After these steps, you can preprocess the data you selected, and now you can start training!

## Training
If you want to train model, you should make sure that you have setup the environment and preprocessed all the data you need.
### Train Multiple Choice Model
`bash ./train_MC.sh`
### Train Question Answering Model
`bash ./train_QA.sh`
### Train End to End Model
`bash ./train_end2end.sh`
