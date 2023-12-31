pipeline {
    agent any
    environment {
        // Docker
        ECR_REGISTRY = "https://hub.docker.com/"
        DOCKERHUB_CREDENTIALS = credentials('Docker-Hub-Registery')
        HTTP_TIMEOUT = '60000' // 60 seconds
        // Kubernetes
        CLUSTER_NAME = 'petclinic-cluster' // Set your cluster name here
        AWS_REGION = 'ap-south-1' // Set your AWS region here
		
    }
    stages {
        stage('Checkout') {
            steps {
                slackSend(message: "Checkout stage started", botUser: true)
                git branch: 'main', url: 'https://github.com/harshalhalkare/my-petclinic.git'
                slackSend(message: "Checkout stage completed", color: 'good'  ) // Success notification with green color
            }
        }
        
        stage('Static Code Analysis') {
            steps {
                sh 'echo test'
                 slackSend(message: "Static Code Analysis stage started"  )
                 //sh './mvnw clean compile spotbugs:check' // Run static code analysis with SpotBugs
                 //sh './mvnw spotbugs:spotbugs -Dspotbugs.outputFile=output/spotbugs-report.xml' // Generate XML report
                 slackSend(message: "Static Code Analysis stage completed", color: 'good'  ) // Success notification with green color
            }
        }
        
        // next stage
        stage('Build') {
            steps {
                script {
                    sh 'echo test'
                     slackSend(message: "Build stage started"  )
                     sh './mvnw clean package' // Build the Java application using Maven
                     slackSend(message: "Build stage completed", color: 'good'  ) // Success notification with green color
                }
            }
        }
        
        // next stage
        stage('Build Docker Image') {
            steps {
                script {
                     slackSend(message: "Build Docker Image stage started"  )
                    docker.build("${DOCKERHUB_CREDENTIALS_USR}/petclinic-app:${env.BUILD_NUMBER}", "-f Dockerfile .")
                     slackSend(message: "Build Docker Image stage completed", color: 'good'  ) // Success notification with green color
                }
            }
        }
        
        // next stage
        stage('Publish') {
            steps {
                script {
                     slackSend(message: "Publish stage started"  )
                    // docker.withRegistry("${ECR_REGISTRY}", 'docker') {
                    //     docker.image("petclinic-app:${env.BUILD_NUMBER}").push()
                    // }
                    
                    //sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    //sh 'docker push ${DOCKERHUB_CREDENTIALS_USR}/petclinic-app:${BUILD_NUMBER}'
                     slackSend(message: "Publish stage completed", color: 'good'  ) // Success notification with green color
                }
            }
        }
        
        // next stage
        stage('Deploy to AWS Kubernetes') {
            steps {
                //script {
                     slackSend(message: "Deploy to AWS Kubernetes stage started"  )
                   // withCredentials([
                     //   usernamePassword(credentialsId: 'aws-credentials-id', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')
                   // ]) {
                     //   sh 'aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION'
                        // sh 'sed -i "s|your-image-from-docker-hub|${DOCKERHUB_CREDENTIALS_USR}/petclinic-app:${BUILD_NUMBER}|g" deployment.yaml'
                       // sh 'kubectl apply -f deployment.yaml' // Apply the Kubernetes deployment
                      //    sh 'echo test'
                    //}
                     slackSend(message: "Deploy to AWS Kubernetes stage completed", color: 'good'  ) // Success notification with green color
//                }
                         sh 'echo test'
            }
        }
        
        // next stage
        // next stage
    }
    post {
        always {
            sh 'docker logout'
        }
		  success {
            // Send Slack notification on build success
            slackSend(
                color: 'good', // 'good' for success, 'danger' for failure, 'warning' for warning, etc.
                message: "Pipeline succeeded! :white_check_mark:"
                
            )
        }
        failure {
            // Send Slack notification on build failure
            slackSend(
                color: 'danger',
                message: "Pipeline failed! :x:"
            )
        }
    }
}
