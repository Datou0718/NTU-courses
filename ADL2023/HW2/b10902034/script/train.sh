export CUDA_VISIBLE_DEVICES=1
file=$(date +'%F_%T')
python3 train.py \
    --train_file ./data/preprocessed/train.json \
    --validation_file ./data/preprocessed/public.json \
    --max_source_length 2048 \
    --source_prefix "summarize: " \
    --summary_column title \
    --max_target_length 128 \
    --pad_to_max_length \
    --model_name_or_path google/mt5-small \
    --text_column maintext \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --learning_rate 1e-4 \
    --num_train_epochs 0 \
    --checkpointing_steps epoch \
    --gradient_accumulation_steps 1 \
    --output_dir ./model/curve/20 \
    --seed 71821 \
    --num_beams 4 \
    --resume_from_checkpoint ./model/report/epoch_19\
    --with_tracking \


