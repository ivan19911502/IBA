from cryptography.fernet import Fernet

# Генерируем ключ шифрования
key = Fernet.generate_key()
cipher_suite = Fernet(key)

# Читаем исходный текстовый файл
with open('text.txt', 'rb') as file:
    original_file_data = file.read()

# Шифруем данные
encrypted_data = cipher_suite.encrypt(original_file_data)

# Сохраняем зашифрованные данные в новый файл
with open('encrypted_file.txt', 'wb') as encrypted_file:
    encrypted_file.write(encrypted_data)

# Выводим ключ шифрования (его нужно сохранить для дешифровки)
print(f'Ключ шифрования: {key.decode()}')

