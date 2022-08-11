1. openssl genrsa -out localhost.key 2048
2. openssl req -key localhost.key -new -out localhost.csr
3. openssl x509 -req -in localhost.csr -signkey localhost.key -out localhost.pem -days 3650 -sha256 -extfile v3.ext