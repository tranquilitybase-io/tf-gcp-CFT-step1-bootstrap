pipeline {
    agent {
        kubernetes {
          label 'kubepod' 
          defaultContainer 'gcloud' 
        }
    }
    environment {
       def bootstrap_params = "${bootstrap_params}"

        
  }
    stages {
        
        stage ('Test received params') {
            steps {
                sh 'echo "\$bootstrap_params"\'
            }
        }
        stage('Activate GCP Service Account and Set Project') {
            steps {
                
                container('gcloud') {

                    sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud config list'

                }
            }
            
        }
       stage('Setup Terraform & Dependencies') {
             steps {
                 container('gcloud') {
//                      sh '''
                       
                      sh 'apt-get -y install jq wget unzip'
//                          wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.13.7/terraform_0.13.7_linux_amd64.zip
//                          unzip -q /tmp/terraform.zip -d /tmp
//                          chmod +x /tmp/terraform
//                          mv /tmp/terraform /usr/local/bin
//                          rm /tmp/terraform.zip
//                          terraform --version
//                         '''
                 }
             }

         }
//          stage('Deploy CFT 0-bootstrap') {
//              steps {
//                  container('gcloud') {
//                      sh '''
                        
//                          cd ./scripts/0-bootstrap/ && echo \"$bootstrap_params\" | jq "." > terraform.auto.tfvars.json
//                          cat terraform.auto.tfvars.json
//                          cd ../.. && make bootstrap
//                          cd ./bootstrap/terraform-example-foundation/0-bootstrap && CLOUD_BUILD_PROJECT_ID=$(terraform output cloudbuild_project_id)
//                          terraform_service_account=$(terraform output terraform_service_account) && gcs_bucket_tfstate=$(terraform output gcs_bucket_tfstate)
//                          echo \"$CLOUD_BUILD_PROJECT_ID\" && echo \"$terraform_service_account\" && echo \"$gcs_bucket_tfstate\"
//                          echo "CFT bootstrap is now deployed"
//                          '''
    
//                  }
               
//              }
//          }
    
    
    }
    
    
    
}
