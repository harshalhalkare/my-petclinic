pipeline {
    agent any
    environment {
        ECR_REGISTRY = "https://hub.docker.com/"
        DOCKERHUB_CREDENTIALS = credentials('Docker-Hub-Registery')
        HTTP_TIMEOUT = '60000' // 60 seconds
    }
    stages {
        stage('Checkout') {
            steps {
                //slackNotify("Checkout stage started")
                git branch: 'main', url: 'https://github.com/harshalhalkare/my-petclinic.git'
                //slackNotify("Checkout stage completed", 'good') // Success notification with green color
            }
        }
        
        stage('Static Code Analysis') {
            steps {
                sh 'echo test'
                //slackNotify("Static Code Analysis stage started")
                //sh './mvnw clean compile spotbugs:check' // Run static code analysis with SpotBugs
                //sh './mvnw spotbugs:spotbugs -Dspotbugs.outputFile=output/spotbugs-report.xml' // Generate XML report
                //slackNotify("Static Code Analysis stage completed", 'good') // Success notification with green color
            }
        }
        //next stage
        stage('Build') {
            steps {
                script {
                    sh 'echo test'
                    //slackNotify("Build stage started")
                    //sh './mvnw clean package' // Build the Java application using Maven
                    //slackNotify("Build stage completed", 'good') // Success notification with green color
                }
            }
        }
        //next stage
        stage('Build Docker Image') {
            steps {
                script {
                    //slackNotify("Build Docker Image stage started")
                    docker.build("${DOCKERHUB_CREDENTIALS_USR}/petclinic-app:${env.BUILD_NUMBER}", "-f Dockerfile .")
                    //slackNotify("Build Docker Image stage completed", 'good') // Success notification with green color
                }
            }
        }
        //next stage
        stage('Publish') {
            steps {
                script {
                    //slackNotify("Publish stage started")
                    //docker.withRegistry("${ECR_REGISTRY}", 'docker') {
                    //    docker.image("petclinic-app:${env.BUILD_NUMBER}").push()
                    //}
                    
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh 'docker push ${DOCKERHUB_CREDENTIALS_USR}/petclinic-app:${BUILD_NUMBER}'
                    //slackNotify("Publish stage completed", 'good') // Success notification with green color
                }
            }
        }
        //next stage
        //next stage
    }
    post {
    always {
      sh 'docker logout'
    }
  }
  }
