export CUDA_VISIBLE_DEVICES=2
python3 ppl.py \
  --base_model_path ./Taiwan-LLM-7B-v2.0-chat \
  --peft_path ./adapter_checkpoint/r4_batch1_epo2 \
  --test_data_path ./data/public_test.json
