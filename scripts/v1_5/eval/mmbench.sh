#!/bin/bash

SPLIT="mmbench_dev_20230712"

sh /data/lychen/code/key.sh

python -m llava.eval.model_vqa_mmbench \
--model-path liuhaotian/llava-v1.5-13b \
--question-file ./playground/data/eval/mmbench/$SPLIT.tsv \
--answers-file ./playground/data/eval/mmbench/answers/$SPLIT/llava-v1.5-13b-beta05_1.jsonl \
--single-pred-prompt \
--temperature 0 \
--conv-mode vicuna_v1

mkdir -p playground/data/eval/mmbench/answers_upload/$SPLIT

python scripts/convert_mmbench_for_submission.py \
    --annotation-file ./playground/data/eval/mmbench/$SPLIT.tsv \
    --result-dir ./playground/data/eval/mmbench/answers/$SPLIT \
    --upload-dir ./playground/data/eval/mmbench/answers_upload/$SPLIT \
    --experiment llava-v1.5-13b-beta025


python /data/lychen/code/decoding/opencompass/tools/eval_mmbench.py /data/lychen/code/decoding/LLaVA/playground/data/eval/mmbench/answers_upload/mmbench_dev_20230712/llava-v1.5-13b-beta025.xlsx --meta /data/lychen/code/decoding/LLaVA/playground/data/eval/mmbench/mmbench_dev_20230712.tsv