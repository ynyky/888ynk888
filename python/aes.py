import base64
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
#from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import os 


def generate_aes128_key():
    """Generates a random AES-128 key encoded in base64 format.

    Returns:
        str: The base64-encoded AES-128 key.
    """

    salt = os.urandom(16)  # Generate a random salt
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,  # 32 bytes for AES-128 key
        salt=salt,
        iterations=100000,  # Adjust iterations as needed
    )

    key = kdf.derive(b"your_strong_password")  # Derive the AES-128 key

    return base64.b64encode(key).decode()

if __name__ == "__main__":
    code = generate_aes128_key()
    print(code)
