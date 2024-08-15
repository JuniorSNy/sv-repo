import random

# 从64个网络流的信息中生成2048个32位宽的随机数
flow_info = [random.getrandbits(32) for _ in range(64)]
random_info = [flow_info[random.randint(0,63)] for _ in range(2048)]

# 将随机数以32位16进制格式写入到文件
with open('head_info.txt', 'w') as file:
    for number in random_info:
        file.write(f"{number:08x}\n")
        

random_flow = [random.getrandbits(32) for _ in range(2048)]
with open('buff_addr.txt', 'w') as file:
    for number in random_flow:
        file.write(f"{number:08x}\n")
        

random_flow = [random.getrandbits(32)%32 for _ in range(2048)]
with open('buff_gapn.txt', 'w') as file:
    for number in random_flow:
        file.write(f"{number:08x}\n")
        
print("随机数已生成并以16进制格式写入到random_numbers_hex.txt文件中。")
