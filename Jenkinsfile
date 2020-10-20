pipeline {
     agent any
     stages {
         
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Image') {
              steps {
                  sh 'docker build -t vacationSpot'
                  sh 'docker image ls'
              }
         }
         stage('Security Scan') {
              steps { 
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail' , outputFormat: 'html'
              }
         }
         stage('Push Image') {
              steps {
                  
              }
         }
         stage('Set current kubectl context') {
             steps{
             
            }
         }
         stage('Deploy container') {
             steps{
             
            }
         
     }
}
