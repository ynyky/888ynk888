import requests
from msal import ConfidentialClientApplication
import json
# Azure AD credentials
TENANT_ID = '<TENANT_ID>'
## PROD
CLIENT_ID = '<CLIENT_ID>'
CLIENT_SECRET = '<CLIENT_SECRET>'
APP_ID = '<OBJECT_ID>'
SCOPE = ['https://graph.microsoft.com/.default']  # MS Graph API permissions
GRAPH_API_URL = 'https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies'
def get_access_token(tenant_id, client_id, client_secret, scope):
    app = ConfidentialClientApplication(
        client_id,
        authority=f'https://login.microsoftonline.com/{tenant_id}',
        client_credential=client_secret
    )
    token_response = app.acquire_token_for_client(scopes=scope)
    if "access_token" in token_response:
        return token_response['access_token']
    else:
        raise Exception(f"Failed to acquire token: {token_response}")
# Create or update the token lifetime policy
def update_token_lifetime_policy(token):
    global policy_id
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }
    # Token lifetime policy details (e.g., 24 hours)
    policy_data = {
        "definition": [
            "{\"TokenLifetimePolicy\":{\"Version\":1,\"AccessTokenLifetime\":\"18:00:00\"}}"
        ],
        "displayName": "CustomTokenLifetimePolicy",
        "isOrganizationDefault": False
    }
    policy_data = json.dumps(policy_data)
    print(policy_data)
    response = requests.post(GRAPH_API_URL, policy_data, headers=headers)
    if response.status_code in (200, 201):
        print(f"Policy 'CustomTokenLifetimePolicy' created/updated successfully!")
        data = (response.content)
        data_str = data.decode('utf-8')
        json_data = json.loads(data_str)
        id_value = json_data['id']
        policy_id = id_value
    else:
        print(f"Failed to update policy: {response.status_code}, {response.text}")
def assign_policy_to_application(token, app_id, policy_id):
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }
    # Assign the policy to the application
    assign_url = f'https://graph.microsoft.com/v1.0/servicePrincipals/{app_id}/tokenLifetimePolicies/$ref'
    payload = {"@odata.id": f"https://graph.microsoft.com/v1.0/policies/tokenLifetimePolicies/{policy_id}"}
    response = requests.post(assign_url, json=payload, headers=headers)
    if response.status_code == 204:
        print(f"Policy assigned to application {app_id} successfully!")
    else:
        print(f"Failed to assign policy to application: {response.status_code}, {response.text}")
if __name__ == "__main__":
    try:       
        # Fetch access token
        access_token = get_access_token(TENANT_ID, CLIENT_ID, CLIENT_SECRET, SCOPE)
        print(access_token)
        # Update the token lifetime policy
        token=update_token_lifetime_policy(access_token)
        assign_policy_to_application(access_token, APP_ID, policy_id)
    except Exception as e:
        print(f"Error: {e}")
