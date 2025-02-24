require 'aws-sdk-ecr'
require 'aws-sdk-sts'
require 'base64'
require 'json'

access_key_id = ENV["AWS_ACCESS_KEY_ID"]
secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
region = ENV["AWS_DEFAULT_REGION"]
assume = ENV["AWS_ASSUME_ROLE"]
account_id = ENV["AWS_ACCOUNT_ID"]

if !account_id
    raise 'setup AWS_ACCOUNT_ID, export AWS_ACCOUNT_ID="example"'
end
def generate_token(access_key_id, secret_access_key,region, account_id,assume: nil)

    region = region
    account_id = account_id 
    access_key_id = access_key_id
    secret_access_key = secret_access_key
    if assume
      puts "Assuming role: #{role_arn}"
    
      sts_client = Aws::STS::Client.new(
        region: region,
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
      )
    
      assumed_role = sts_client.assume_role({
        role_arn: assume,
        role_session_name: 'ecr-access-session'
      })
    
      credentials = assumed_role.credentials
    else
      credentials = Aws::Credentials.new(
        access_key_id,
        secret_access_key
      )
    end
    ecr_client = if assume
      Aws::ECR::Client.new(
        region: region,
        access_key_id: credentials.access_key_id,
        secret_access_key: credentials.secret_access_key,
        session_token: credentials.session_token
      )
    else
      Aws::ECR::Client.new(
        region: region,
        access_key_id: access_key_id,
        secret_access_key: secret_access_key
      )
    end
    response = ecr_client.get_authorization_token
    auth_data = response.authorization_data.first
    
    auth_token = Base64.decode64(auth_data.authorization_token)
    username, password = auth_token.split(':')
    
    registry_url = auth_data.proxy_endpoint
    
    docker_config = { 'auths' => {} }
    
    docker_config['auths'][registry_url] = {
      'auth' => Base64.encode64("#{username}:#{password}").strip
    }
    docker_config = Base64.strict_encode64(docker_config.to_json)
    
    # return docker_config
    puts docker_config
end

generate_token(access_key_id, secret_access_key,region, account_id,assume: nil)