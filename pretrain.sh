#! /bin/bash

NUM_GPUS_PER_WORKER=4

gpt_options=" \
       --train-data-path /home/jovyan/data/crossqa/train.list \
       --max-files-per-process 20000 \
       --logging-dir=/home/jovyan/data/crossqa/ \
       --load-huggingface sberbank-ai/rugpt3xl \
       --save /home/jovyan/data/crossqa/ \
       --tokenizer-path sberbank-ai/rugpt3xl \
       --cache-prefix p5 \
       --save-interval 500 \
       --no-load-optim \
       --finetune \
       --log-interval 100 \
       --model-parallel-size 1 \
       --num-layers 24 \
       --hidden-size 2048 \
       --num-attention-heads 16 \
       --batch-size 2 \
       --seq-length 2048 \
       --max-position-embeddings 2048 \
       --train-iters 20000 \
       --distributed-backend nccl \
       --lr 0.000015 \
       --warmup 0.0 \
       --lr-decay-style constant \
       --weight-decay 1e-2 \
       --fp16 \
       --sparse-mode alternating \
       --checkpoint-activations \
       --deepspeed-activation-checkpointing \
       --deepspeed \
       --deepspeed_config /home/jovyan/data/crossqa/gpt3_xl_sparse_2048.json \
"

run_cmd="USE_DEEPSPEED=1 mpirun --np ${NUM_GPUS_PER_WORKER} python /home/jovyan/ru-gpts/pretrain_gpt3.py $@ ${gpt_options}"
echo ${run_cmd}
eval ${run_cmd}

set +x

