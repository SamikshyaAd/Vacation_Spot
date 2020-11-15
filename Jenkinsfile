pipeline {
     agent any
     stages {
         
         stage('Lint HTML') {
              steps {
                  sh 'echo "Linting HTML"'
                  sh 'tidy -q -e --drop-empty-elements no Application_Code/*.html'
              }
         }
         stage('Build Image') {
              steps {
                  sh 'echo "Building Docker image"'
                  sh 'docker build -t vacationspot .'
                  sh 'docker image ls'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'alpivacationspotne:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail' , outputFormat: 'html'
              }
         }
         stage('Publish to ECR') {
              steps {
                 script{
                      docker.withRegistry('https://470792012930.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:ecr-cred'){
                         sh 'echo "Publishing to ECR"'
                         sh 'docker push 470792012930.dkr.ecr.us-east-2.amazonaws.com/vacationspot:latest'
                    }
                 }
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
