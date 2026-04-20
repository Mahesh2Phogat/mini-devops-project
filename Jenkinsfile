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

        stage('Download httplib header') {
            steps {
                bat '''
                curl -L https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h -o httplib.h
                '''
                echo 'httplib.h downloaded'
            }
        }

        stage('Build') {
            steps {
                bat '''
                cmake -G "MinGW Makefiles" -B build -S .
                cmake --build build
                '''
                echo 'C++ build successful'
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
                echo 'All tests passed'
            }
        }

        stage('Build Docker Image') {
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
                echo 'Container is live on port 5000'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed — check the logs above'
        }
    }
}