# Import dev certs
read -sp "Enter the password for the PFX file: " pfx_password
echo
# Import the certificate with the provided password
dotnet dev-certs https -ep ./localhost.pfx -p "$pfx_password" --trust
# Convert PFX to PEM (which contains both certificate and private key)
openssl pkcs12 -in ./localhost.pfx -out ./localhost.pem -nodes -password pass:"$pfx_password"

# Extract CRT (certificate) and KEY (private key) from PEM
openssl rsa -in ./localhost.pem -out ./localhost.key
openssl x509 -in ./localhost.pem -out ./localhost.crt

echo "For macOS add the .pfx certificate to the system keychain and set Always trust in the certificate info"
