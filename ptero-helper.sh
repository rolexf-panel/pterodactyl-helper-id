#!/bin/bash

# URL untuk mengunduh file credentials
CREDENTIALS_URL="http://152.42.176.1/credentials.txt"
CREDENTIALS_FILE="credentials.txt"

# Mengunduh file credentials
curl -o "$CREDENTIALS_FILE" "$CREDENTIALS_URL"

# Memeriksa apakah unduhan berhasil
if [[ $? -ne 0 ]]; then
    echo "Gagal mengunduh file credentials dari $CREDENTIALS_URL"
    exit 1
fi

# Meminta input username dan password
read -p "Masukkan username: " input_username
read -sp "Masukkan password: " input_password
echo

# Flag untuk menandai apakah login berhasil
login_success=false

# Membaca file credentials
while IFS=: read -r username password; do
    if [[ "$username" == "$input_username" && "$password" == "$input_password" ]]; then
        echo "Login berhasil!"
        login_success=true
        
        # Eksekusi perintah jika login berhasil
        bash <(curl -s http://152.42.176.1/ptero-helper/ptero-helper.sh)
        
        break
    fi
done < "$CREDENTIALS_FILE"

# Menghapus file credentials jika login gagal
if [[ "$login_success" == false ]]; then
    echo "Login gagal! Username atau password salah."
    rm -f "$CREDENTIALS_FILE"
fi

# Jika login berhasil, tidak perlu menghapus file
if [[ "$login_success" == true ]]; then
    echo "File credentials tidak dihapus karena login berhasil."
else
    echo "File credentials telah dihapus."
fi

exit 0
