import random

# 从64个网络流的信息中生成2048个32位宽的随机数
nr_flow = [random.randint(0,63) for _ in range(2048)]
ha_flow = [random.getrandbits(32) for _ in range(64)]

# 将随机数以32位16进制格式写入到文件
with open('head_info.txt', 'w') as file:
    for _ in range(2048):
        file.write(f"nr_flow = {nr_flow[_]:02x}, ha_flow = {ha_flow[nr_flow[_]]:08x}, addr = {random.getrandbits(32):08x}\n")
        

# random_flow = [random.getrandbits(32) for _ in range(2048)]
# with open('buff_addr.txt', 'w') as file:
#     for number in random_flow:
#         file.write(f"{number:08x}\n")
        

# random_flow = [random.getrandbits(32)%32 for _ in range(2048)]
# with open('buff_gapn.txt', 'w') as file:
#     for number in random_flow:
#         file.write(f"{number:08x}\n")
        
print("随机数已生成并以16进制格式写入到random_numbers_hex.txt文件中。")
