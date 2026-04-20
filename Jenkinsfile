pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mini-devops-cpp-app'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Clean') {
            steps {
                bat 'if exist build rmdir /s /q build'
            }
        }

        stage('Build') {
            steps {
                bat 'cmake -G "MinGW Makefiles" -B build -S .'
                bat 'cmake --build build'
            }
        }

        stage('Test') {
            steps {
                bat 'build\\test_app.exe'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build --no-cache -t %IMAGE_NAME% .'
            }
        }

        stage('Run Container') {
            steps {
                bat 'docker stop %IMAGE_NAME% > nul 2>&1'
                bat 'docker rm %IMAGE_NAME% > nul 2>&1'
                bat 'docker run --rm %IMAGE_NAME%
            }
        }
    }
}