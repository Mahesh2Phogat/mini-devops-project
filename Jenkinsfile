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

        stage('Download Dependency') {
            steps {
                bat '''
                curl -L https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h -o httplib.h
                '''
                echo 'Dependency downloaded'
            }
        }

        stage('Clean Build Folder') {
            steps {
                bat '''
                if exist build rmdir /s /q build
                '''
                echo 'Old build folder removed'
            }
        }

        stage('Build') {
            steps {
                bat '''
                cmake -G "MinGW Makefiles" -B build -S .
                cmake --build build
                '''
                echo 'Build successful'
            }
        }

        stage('Test') {
            steps {
                bat '''
                start /B build\\app.exe
                timeout /t 2 > nul
                build\\test_app.exe
                taskkill /IM app.exe /F > nul 2>&1
                '''
                echo 'Tests passed'
            }
        }

        stage('Docker Build') {
            steps {
                bat '''
                docker build -t %IMAGE_NAME% .
                '''
                echo 'Docker image built'
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                docker stop %IMAGE_NAME% > nul 2>&1
                docker rm %IMAGE_NAME% > nul 2>&1
                docker run -d --name %IMAGE_NAME% -p 5000:5000 %IMAGE_NAME%
                '''
                echo 'App running at http://localhost:5000'
            }
        }
    }

    post {
        success {
            echo ' PIPELINE chl rhi hai SHI se'
        }
        failure {
            echo ' PIPELINE FAILED  kuch toh gadbad hai upar'
        }
    }
}