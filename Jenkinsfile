pipeline {
    agent any

    environment {
        IMAGE_NAME = 'mini-devops-cpp-app'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Code pulled from GitHub'
            }
        }

        stage('Clean Build') {
            steps {
                bat '''
                if exist build rmdir /s /q build
                '''
            }
        }

        stage('Build') {
            steps {
                bat '''
                cmake -G "MinGW Makefiles" -B build -S .
                cmake --build build
                '''
            }
        }

        stage('Test') {
            steps {
                bat '''
                build\\test_app.exe
                '''
            }
        }

        stage('Docker Build') {
            steps {
                bat '''
                docker build --no-cache -t %IMAGE_NAME% .
                '''
                echo 'Docker image built (no cache)'
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop %IMAGE_NAME% > nul 2>&1
                docker rm %IMAGE_NAME% > nul 2>&1
                docker run -d --name %IMAGE_NAME% %IMAGE_NAME%
                '''
                echo 'Container running'
            }
        }
    }

    post {
        success {
            echo '🎉 PIPELINE SUCCESSFUL'
        }
        failure {
            echo '❌ PIPELINE FAILED'
        }
    }
}