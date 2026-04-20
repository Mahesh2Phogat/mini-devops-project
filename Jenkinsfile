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
                sh '''
                    curl -L https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h \
                    -o httplib.h
                '''
                echo 'httplib.h downloaded'
            }
        }

        stage('Build') {
            steps {
                sh 'apt-get update && apt-get install -y cmake g++'
                sh 'cmake -B build -S .'
                sh 'cmake --build build'
                echo 'C++ build successful'
            }
        }

        stage('Test') {
            steps {
                sh './build/app &'
                sh 'sleep 2'
                sh './build/test_app'
                sh 'pkill app || true'
                echo 'All tests passed'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest ."
                echo 'Docker image built'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
                    echo 'Image pushed to Docker Hub'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh "docker stop ${IMAGE_NAME} || true"
                sh "docker rm   ${IMAGE_NAME} || true"
                sh "docker run -d --name ${IMAGE_NAME} -p 5000:5000 ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
                echo 'Container is live on port 5000'
            }
        }
    }

    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed — check the logs above' }
    }
}