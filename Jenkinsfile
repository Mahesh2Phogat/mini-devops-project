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

        stage('Build C++ App') {
            steps {
                bat 'g++ app.cpp -o app.exe'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_USER%/%IMAGE_NAME% .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat '''
                    echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
                    docker push %DOCKER_USER%/%IMAGE_NAME%
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop %IMAGE_NAME% > nul 2>&1 || exit /b 0
                docker rm %IMAGE_NAME% > nul 2>&1 || exit /b 0
                docker run -d -p 5000:5000 --name %IMAGE_NAME% %DOCKER_USER%/%IMAGE_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo 'PIPELINE SUCCESSFUL 🚀'
        }
        failure {
            echo 'PIPELINE FAILED ❌'
        }
    }
}