# ADL2023 Homework2

#### Warning: For all the files in this folder, you may need to modify the datapath in the code before you executing them.

## Setup Environment
To setup environment, you can run
`pip install -r requirements.txt`

## Data Preprocess
Since the given input data is .jsonl, and the input format required by train.py is .json, we need to convert jsonl to json before we start training.
`python3 ADL_HW2/preprocess.py --target_path=<input data location> --dest_path=<output data location>`

## Training
To start training, you need to make sure that you have already setup the environment and preprocessed the input file. Also, you may have to customize some arguments in train.sh. After you finish all of them, you can enjoy training!
`bash ./script/train.sh`