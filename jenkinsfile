pipeline {
    agent any

    environment {
        IMAGE_NAME = "mini-devops-cpp-app"
        DOCKER_USER = "lazy2code"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_USER%/%IMAGE_NAME% .'
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker push %DOCKER_USER%/%IMAGE_NAME%'
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop myapp > nul 2>&1 || exit /b 0
                docker rm myapp > nul 2>&1 || exit /b 0
                docker run -d -p 5000:5000 --name myapp %DOCKER_USER%/%IMAGE_NAME%
                '''
            }
        }
    }
}