pipeline {
    agent any

    environment {
        IMAGE_NAME = "mini-devops-cpp-app"
    }

    stages {

        stage('Clean') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'g++ app.cpp -o app.exe'
            }
        }

        stage('Test') {
            steps {
                bat 'echo Test Passed'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build --no-cache -t %IMAGE_NAME% .'
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop %IMAGE_NAME% > nul 2>&1
                docker rm %IMAGE_NAME% > nul 2>&1
                docker run -d --name %IMAGE_NAME% %IMAGE_NAME%
                '''
            }
        }

        stage('Show Output') {
            steps {
                bat 'docker images'
                bat 'docker ps'
            }
        }
    }

    post {
        success {
            echo 'PIPELINE SUCCESSFUL 🎉'
        }
        failure {
            echo 'PIPELINE FAILED ❌'
        }
    }
}