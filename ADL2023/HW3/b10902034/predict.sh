export CUDA_VISIBLE_DEVICES=2
python3 inference.py \
  --base_model_path ./Taiwan-LLM-7B-v2.0-chat \
  --peft_path ./adapter_checkpoint/r4_batch1_epo2 \
  --test_data_path ./data/private_test.json \
  --output_path ./prediction.json
