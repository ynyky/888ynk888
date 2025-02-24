#!/bin/bash

# Set the key name and location
KEY_NAME="$HOME/.ssh/id_rsa"  # Change this to your desired key name and location
KEY_TYPE="rsa"                 # You can also use "ed25519" for a different key type
KEY_BITS=4096                  # Key size for RSA (you can change it for other types)

# Check if the key already exists
if [[ -f "$KEY_NAME" ]]; then
    echo "Key already exists at $KEY_NAME. Please choose a different name or location."
    exit 1
fi

# Generate the SSH key pair
ssh-keygen -t $KEY_TYPE -b $KEY_BITS -f $KEY_NAME -C "your_email@example.com" -N ""

# Display success message
echo "SSH key pair generated:"
echo "Private key: $KEY_NAME"
echo "Public key: ${KEY_NAME}.pub"