pipeline {
     agent any
     stages {
         
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e /Application_Code/*.html'
              }
         }
         stage('Build Image') {
              steps {
                  sh 'docker build -t vacationSpot .'
                  sh 'docker image ls'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail' , outputFormat: 'html'
              }
         }
         stage('Publish to ECR') {
              steps {
                  sh 'echo "Inside publish"'
              }
         }
         stage('Set current kubectl context') {
             steps{
                  sh 'echo "Inside kubectl"'
            }
         }
         stage('Deploy container') {
             steps{
                  sh 'echo "Inside Deploy"'
            }
         
          }
     }
}
