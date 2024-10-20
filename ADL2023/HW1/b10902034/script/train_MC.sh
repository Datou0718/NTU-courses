export CUDA_VISIBLE_DEVICES=2
file=roberta_5
python3 multiple-choice.py \
  --model_name_or_path hfl/chinese-roberta-wwm-ext \
  --train_file ./dataset/preprocessed/train_MC.json \
  --validation_file ./dataset/preprocessed/valid_MC.json \
  --max_seq_length 512 \
  --per_device_train_batch_size 8 \
  --per_device_eval_batch_size 8 \
  --gradient_accumulation_steps 2 \
  --learning_rate 3e-5 \
  --num_train_epochs 5 \
  --seed 71821 \
  --output_dir ./submit_model/MC/$file
