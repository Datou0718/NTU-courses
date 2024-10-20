export CUDA_VISIBLE_DEVICES=0
file=end2end
python3 question-answering.py \
  --model_name_or_path hfl/chinese-roberta-wwm-ext \
  --train_file ./dataset/preprocessed/train_end2end.json \
  --validation_file ./dataset/preprocessed/valid_end2end.json \
  --max_seq_length 512 \
  --per_device_train_batch_size 8 \
  --per_device_eval_batch_size 8 \
  --gradient_accumulation_steps 2 \
  --learning_rate 3e-5 \
  --num_train_epochs 3 \
  --seed 821 \
  --pad_to_max_length \
  --with_tracking \
  --output_dir ./model/"$file"
