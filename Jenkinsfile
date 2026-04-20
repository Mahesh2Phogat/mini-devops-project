pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'Lazy2Code'
        IMAGE_NAME     = 'mini-devops-cpp-app'
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
                cmake -B build -S .
                cmake --build build
                '''
                echo 'C++ build successful'
            }
        }

        stage('Test') {
            steps {
                bat '''
                start /B build\\app.exe
                timeout /t 2
                build\\test_app.exe
                taskkill /IM app.exe /F
                '''
                echo 'All tests passed'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKERHUB_USER%/%IMAGE_NAME%:latest ."
                echo 'Docker image built'
            }
        }

        // OPTIONAL (skip for now if you don’t have DockerHub credentials)
        // stage('Push to Docker Hub') {
        //     steps {
        //         echo 'Skipping push for now'
        //     }
        // }

        stage('Deploy Container') {
            steps {
                bat '''
                docker stop %IMAGE_NAME% || exit 0
                docker rm %IMAGE_NAME% || exit 0
                docker run -d --name %IMAGE_NAME% -p 5000:5000 %DOCKERHUB_USER%/%IMAGE_NAME%:latest
                '''
                echo 'Container is live on port 5000'
            }
        }
    }

    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed — check the logs above' }
    }
}