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
                 script{
                      docker.withRegistry('https://470792012930.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:jenkins'){
                         sh 'echo "Publish to ECR"'
                         sh 'docker push 470792012930.dkr.ecr.us-west-2.amazonaws.com/capstone-sample-app:latest'
                    }
                 }
              }
          }
         stage('Kubernetes Deploy') {
             steps{
                 withAWS(credentials: 'jenkins', region: 'us-west-2') {
					sh 'aws eks --region us-west-2 update-kubeconfig --name UdacityCapStone-Cluster'
					// Configure deployment
					sh 'kubectl apply -f k8s/deployment.yml'
					// Configure service for loadbalancing
					sh 'kubectl apply -f k8s/service.yml'
					// Set created image for rolling update
					sh 'kubectl set image deployments/capstone-sample-app capstone-sample-app=470792012930.dkr.ecr.us-west-2.amazonaws.com/capstone-sample-app:latest'
				}
            }
          }
     }
     post {
		always {
		    // remove docker image 
		    sh 'docker rmi capstone-sample-app | true'
		}
	}
}
