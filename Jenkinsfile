  pipeline{
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
	
        stages{
		 stage('Git Checkout'){
		     steps{
	        git 'https://github.com/Smaheshwar85/java-webserver-master'  
	        
           }
		 }
          
        stage('Build') {
            steps {
                // Assuming you have a Maven project
                sh 'mvn clean package -DskipTests'
                archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
            }
        }
        
 stage('Build Docker Image') {
    steps {
        script {
            sh "docker build -t ${GCR_REGISTRY}/${PROJECT_ID}/${IMAGE_NAME}:${env.BUILD_NUMBER} ."
        }
    }
}
		
stage('Push to GCR') {
    steps {
	    sh'''
     gcloud auth activate-service-account'''
        sh "docker push ${GCR_REGISTRY}/${PROJECT_ID}/${IMAGE_NAME}:${env.BUILD_NUMBER}"
    }
}
    
            
    }
}
