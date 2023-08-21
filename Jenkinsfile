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
                    def dockerImageTag = "${GCR_REGISTRY}/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker build -t $dockerImageTag ."
                    sh "docker push $dockerImageTag"
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
