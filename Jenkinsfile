pipeline {
      agent any 
   tools {
    maven 'M3'
  }
    environment {
        GCR_REGISTRY = "gcr.io" // Change to your GCR registry URL
        PROJECT_ID = "devopsjunction23" // Change to your GCP Project ID
        IMAGE_NAME = "java-webserver" // Change to your desired image name
        IMAGE_TAG = "latest" // Change to your desired image tag
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                script {
                    git url: 'https://github.com/Smaheshwar85/java-webserver-master'  
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean package -DskipTests'
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    
                  sh '''
                  
                  gcloud artifacts repositories create xyz-java2 --repository-format=docker --location=us-central1 --description="created repo"
                  gcloud auth configure-docker us-central1-docker.pkg.dev'''

                 sh "docker tag gcr.io/alert-result-396707/java-webserver us-central1-docker.pkg.dev/alert-result-396707/xyz-java2/gcr.io/alert-result-396707/java-webserver"
                  sh "docker push us-central1-docker.pkg.dev/alert-result-396707/xyz-java2/gcr.io/alert-result-396707/java-webserver"
                      
                    //sh "docker build -t $dockerImageTag ."
                    //sh "docker tag gcr.io/devopsjunction23/java-webserver us-central1-docker.pkg.dev/my-project/my-repo/test-imagemy-image"
                    //sh "docker push us-central1-docker.pkg.dev/my-project/my-repo/test-imagemy-image"
                }
            }
        }
        
      stage('Cleanup') {
            steps {
                sh 'docker rmi -f $(docker images -f "dangling=true" -q)'
            }
        }
    }
}
