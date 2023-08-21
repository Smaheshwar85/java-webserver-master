pipeline{
    agent any  
     tools {
    maven 'M3'
  }
    environment {
        //PROJECT_ID = 'your-project-id'
        IMAGE_NAME = 'sep-test'
        TEST_IMAGE_TAG = "test-${BUILD_NUMBER}"
        PROD_IMAGE_TAG = "prod-${BUILD_NUMBER}"
        //GCR_CREDENTIALS = credentials('your-gcr-credentials-id')
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
        
        stage('deploy to test') {
            steps {
                //withCredentials([file(credentialsId: 'cred', variable: 'CRED')]){
                // Assuming you have a Maven project
                sh '''
                gcloud init
                gcloud auth activate-service-account --key-file="$CRED"
                gcloud app deploy target/java-webserver-1.0.0.jar
                '''
            }
            
        }
            
    }
}
