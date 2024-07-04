
# Скрипт для подсчета количества заглавных букв в строке
user_input = input("Enter string: ")
count_upper = sum(1 for count in user_input if count.isupper())
print("Count:", count_upper)
