import os
result = os.system("ping -c 1 google.com")

if result == 0:
    print('success')
else:
    print("doesn't work")