pipeline {
     agent any
     stages {
         
         stage('Lint HTML') {
              steps {
                  sh 'echo "Lint HTML"'
                  sh 'tidy -q -e --drop-empty-elements no Application_Code/*.html'
              }
         }
         stage('Build Image') {
              steps {
                  sh 'echo "Build Docker image"'
                  sh 'docker build -t capstone-sample-app .'
                  sh 'docker image ls'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'capstone-sample-app:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail' , outputFormat: 'html'
              }
         }
         stage('Publish to ECR') {
              steps {
                 sh 'echo "Publish to ECR"'
              }
          }
         stage('Kubernetes Deploy') {
             steps{
                  sh 'echo "Deploy to K8s"'
            }
          }
     }
}
