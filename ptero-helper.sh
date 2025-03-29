# URL untuk mengunduh file credentials
CREDENTIALS_URL="http://152.42.176.1/credentials.txt"
CREDENTIALS_FILE="credentials.txt"

# Mengunduh file credentials
curl -o "$CREDENTIALS_FILE" "$CREDENTIALS_URL"

# Memeriksa apakah unduhan berhasil
if [[ $? -ne 0 ]]; then
    echo "Gagal mengunduh file credentials dari $CREDENTIALS_URL"
fi

# Meminta input username dan password
read -p "Masukkan username: " input_username
read -sp "Masukkan password: " input_password
echo

# Membaca file credentials
while IFS=: read -r username password; do
    if [[ "$username" == "$input_username" && "$password" == "$input_password" ]]; then
        echo "Login berhasil!"
        # Menghapus file setelah berhasil login
        rm -f "$CREDENTIALS_FILE"
        bash <(curl -s http://152.42.176.1/ptero-helper/ptero-helper.sh)
else
        echo "Login Gagal!"
        rm -rf "credentials.tx"
        exit 1
