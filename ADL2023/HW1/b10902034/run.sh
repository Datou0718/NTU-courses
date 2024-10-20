if [[ "${1:0:1}" != "/" ]]; then
    abs_path_1=$(readlink -f "$1")
else
    abs_path_1=$1
fi

if [[ "${2:0:1}" != "/" ]]; then
    abs_path_2=$(readlink -f "$2")
else
    abs_path_2=$2
fi

if [[ "${3:0:1}" != "/" ]]; then
    abs_path_3=$(readlink -f "$3")
else
    abs_path_3=$3
fi

cd cloud/data
python3 preprocess.py --context_path="$abs_path_1" --test_path="$abs_path_2" --model_type=MC
python3 MC_inference.py
python3 preprocess.py --context_path="$abs_path_1" --test_path="$abs_path_2" --model_type=QA
python3 QA_inference.py --prediction_path="$abs_path_3"