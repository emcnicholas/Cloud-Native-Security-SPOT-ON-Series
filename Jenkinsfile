// Pipeline as Code
pipeline{
    agent any

    // Environment Variables //
    environment{
        ENVIRONMENT_NAME       = 'SPOT_ON'
        PROD_ENV_ID            = 'Prod'
        AWS_ACCESS_KEY_ID      = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY  = credentials('aws-secret-key')
        PROD_AWS_REGION        = 'us-east-2'
        PROD_AWS_AZ1           = 'us-east-2a'
        PROD_AWS_AZ2           = 'us-east-2b'
        FTD_USERNAME           = credentials('ftd-username')
        FTD_PASSWORD           = credentials('ftd-password')
        AWS_SSH_KEY_NAME       = 'ftd_key'
        SCA_SERVICE_KEY        = credentials('sca-service-key')
        SW_API_KEY             = credentials('sw-api-key')
        SW_API_SEC             = credentials('sw-api-sec')
        SW_URL                 = credentials('sw-url')
        SW_ROOT_SCOPE          = credentials('sw-root-scope')
    }
    stages{
        // This stage will run Terraform Apply when "Deploy Env" is added to the commit message //
        stage('Build Environment'){
           when{
                allOf{
                    branch "main"
                    changelog "Deploy Env*"
                }
            }
           steps{
                echo "Building Environment"
                sh 'terraform get -update'
                sh 'terraform init'
                sh 'terraform apply -auto-approve \
                -var="aws_access_key=$AWS_ACCESS_KEY_ID" \
                -var="aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
                -var="env_name=$ENVIRONMENT_NAME" \
                -var="env_id=$PROD_ENV_ID" \
                -var="region=$PROD_AWS_REGION" \
                -var="aws_az1=$PROD_AWS_AZ1" \
                -var="aws_az2=$PROD_AWS_AZ2" \
                -var="ftd_pass=$FTD_FTD_USERNAME" \
                -var="ftd_pass=$FTD_PASSWORD" \
                -var="key_name=$AWS_SSH_KEY_NAME" \
                -var="sca_service_key=$SCA_SERVICE_KEY" \
                -var="secure_workload_api_key=$SW_API_KEY" \
                -var="secure_workload_api_sec=$SW_API_SEC" \
                -var="secure_workload_api_url=$SW_URL" \
                -var="secure_workload_root_scope=$SW_ROOT_SCOPE"'
            }
        }
        // This stage will destroy the environment when "Destroy Environment" is added to the commit message
        stage('Destroy Environment'){
            when{
                allOf{
                    branch "main"
                    changelog "Destroy Environment*"
                }
            }

            steps{
                echo "Destroying Environment"
                sh 'terraform destroy -auto-approve \
                -var="aws_access_key=$AWS_ACCESS_KEY_ID" \
                -var="aws_secret_key=$AWS_SECRET_ACCESS_KEY" \
                -var="env_name=$ENVIRONMENT_NAME" \
                -var="env_id=$PROD_ENV_ID" \
                -var="region=$PROD_AWS_REGION" \
                -var="aws_az1=$PROD_AWS_AZ1" \
                -var="aws_az2=$PROD_AWS_AZ2" \
                -var="ftd_pass=$FTD_FTD_USERNAME" \
                -var="ftd_pass=$FTD_PASSWORD" \
                -var="key_name=$AWS_SSH_KEY_NAME" \
                -var="sca_service_key=$SCA_SERVICE_KEY" \
                -var="secure_workload_api_key=$SW_API_KEY" \
                -var="secure_workload_api_sec=$SW_API_SEC" \
                -var="secure_workload_api_url=$SW_URL" \
                -var="secure_workload_root_scope=$SW_ROOT_SCOPE"'
            }
        }
    }
}