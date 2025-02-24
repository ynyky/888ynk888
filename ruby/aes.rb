require 'openssl'
require 'base64'
require 'securerandom'

def generate_random_password(length = 12)
  characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['@', '#', '$', '%', '&', '*']
  password = Array.new(length) { characters.sample }.join
  password
end
def generate_aes128_key
  key = OpenSSL::Random.random_bytes(16) 
  base64_key = Base64.strict_encode64(key)
  { key: base64_key }
end

# Example usage
key_info = generate_aes128_key

puts "Key: #{key_info[:key]}"


