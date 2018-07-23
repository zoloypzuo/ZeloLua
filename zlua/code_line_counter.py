import os
import re

n_lines=0
fns=[i for i in os.listdir() if i.endswith('.cs')]
for fn in fns:
	with open(fn,'r',encoding='utf-8') as f:
		for i in f:
			n_lines+=1
print(n_lines)
