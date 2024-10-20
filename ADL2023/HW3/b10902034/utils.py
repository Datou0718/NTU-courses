from transformers import BitsAndBytesConfig
import torch

def get_prompt(instruction: str) -> str:
    '''Format the instruction as a prompt for LLM.'''
    return f"你是一名中文系教授，以下是學生對文言文或現代文的問題。請提供他們有用且精確無誤的答案。學生: {instruction} 教授:"
    # return f"你是一名中文系教授，以下是學生對文言文或現代文的問題。請提供他們有用且精確無誤的答案。\
    #          學生一：「第二年召迴朝廷，改任著作佐郎，直史館，改任左拾遺。翻譯成文言文：」\
    #          教授：明年召還，改著作佐郎，直史館，改左拾遺。\
    #          學生二：「文言文翻譯：中宗與庶人嘗因正月十五日夜幸其第，賜賚不可勝數。」\
    #          教授： 唐中宗與韋庶人曾經在正月十五日夜到韋安石的宅第，並賜賞給他不可勝數的財物。\
    #          學生：「{instruction}」 \
    #          教授："

def get_bnb_config() -> BitsAndBytesConfig:
    '''Get the BitsAndBytesConfig.'''
    config = BitsAndBytesConfig(
        load_in_4bit = True,
        bnb_4bit_compute_dtype = torch.bfloat16
    )
    
    return config


