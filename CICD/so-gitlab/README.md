
1. Assumptions
Directory Structure: The -chdir=$TF_DIR option is used to specify the directory where Terraform configuration files are located. This assumes that Terraform files are in infra/terraform, and your CI/CD pipeline operates with this directory structure.

Terraform State Outputs: The terraform output -raw staging_ip and terraform output -raw production_ip commands are used to retrieve IP addresses. This assumes that these outputs are correctly defined in your Terraform configurations and are available after terraform apply.

Environment Variables: Variables like AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and SSH_PUB are assumed to be correctly set in the CI/CD environment and available for Terraform and deployment scripts.

File Paths for Artifacts: Artifacts are written to STAGING_IP.txt and PRODUCTION_IP.txt in the root of the project directory. This assumes that this path is accessible and correct within the CI/CD pipeline.

SSH Configuration: The script uses ssh-keyscan to add IP addresses to known_hosts. This assumes that the EC2 instances are accessible and that their SSH keys can be retrieved without issue.

Docker Login and Operations: The deployment script assumes that Docker login and image operations are correctly configured and that Docker is installed and running on the EC2 instances.

Branch Restrictions: Some jobs only run on the main branch. It assumes that the main branch is used for production deployments and that other branches might not trigger all stages.

2. Technologies Chosen
GitLab CI/CD: Used for managing the pipeline stages and automating the deployment process. GitLab CI/CD handles different stages of your pipeline like building, deploying, and testing.

Terraform: For infrastructure as code (IaC) to manage AWS resources. Terraform is used to initialize, plan, apply, and destroy infrastructure resources in AWS.

Docker: Used for containerization. Docker images are built and pushed to Amazon ECR (Elastic Container Registry) and then pulled and run on EC2 instances.

AWS CLI: Used for interacting with AWS services from the CI/CD pipeline. This includes actions like logging into ECR and managing Docker images.

jq: A command-line tool for processing JSON, used here to convert Terraform output into environment variable format.

ssh-keyscan: Used to automatically add the SSH host keys of EC2 instances to known_hosts to avoid SSH warnings during deployment.

apk: The package manager for Alpine Linux used in the Docker container to install necessary packages like aws-cli and docker.



3. Requirements:
In `infra/terraform/requirements` you have some helper tools to setup below requirements.
- s3 bucket - setup in CI/CD as $BUCKET_NAME
- Dynamodb table - setup in CI/CD as $DYNAMO_DB_NAME
- ECR repository - setup in CI/CD as $AWS_REPOSITORY
- ssh private, public key - setup in CI/CD as $SSH_PUB and $SS_PRIV
4. Aditional INFO:

!Monitoring is not setuped.
