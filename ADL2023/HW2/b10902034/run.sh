python3 ./ADL_HW2/preprocess.py --target_path=$1 --dest_path=./public.json
python3 ./script/predict.py --input=./public.json --output=$2 --model=./ADL_HW2/model