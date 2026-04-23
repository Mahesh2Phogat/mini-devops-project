# Mini DevOps Project Code Documentation

## Overview
This project demonstrates a CI/CD pipeline using Jenkins, Docker, and CMake for a C++ application. It includes building, testing, and containerizing a simple C++ program.

## Files

### app.cpp
**Description:** Main application file that prints messages indicating the DevOps pipeline is running inside Docker and waits for user input to keep the container alive.

```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "DevOps Pipeline Running inside Docker..." << endl;
    cout << "Container is active. Press Enter to exit..." << endl;

    cin.get();   // keeps container alive

    return 0;
}
```

### test_app.cpp
**Description:** Test file that defines simple add and subtract functions and runs basic tests to verify their correctness.

```cpp
#include <iostream>
using namespace std;

int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }

int main() {
    cout << "Running tests...\n";

    if(add(2,3) == 5 && sub(5,3) == 2) {
        cout << "All tests PASSED\n";
        return 0;
    } else {
        cout << "Tests FAILED\n";
        return 1;
    }
}
```

### CMakeLists.txt
**Description:** CMake configuration file that sets up the project to build two executables: 'app' from app.cpp and 'test_app' from test_app.cpp.

```cmake
cmake_minimum_required(VERSION 3.10)

project(DevOpsCalculator)

set(CMAKE_CXX_STANDARD 11)

add_executable(app app.cpp)
add_executable(test_app test_app.cpp)
```

### Dockerfile
**Description:** Docker configuration file that creates a container image based on Ubuntu, installs g++, copies the project files, builds the app, and sets the command to run it.

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y g++

WORKDIR /app

COPY . .

RUN g++ app.cpp -o app

CMD ["./app"]
```

### Jenkinsfile
**Description:** Jenkins pipeline script that defines stages for cleaning, checking out code, building with g++, testing (placeholder), building Docker image, running the container, and showing output.

```groovy
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
```

### readme.md
**Description:** Project readme file providing an overview, features, tools used, and pipeline flow.

```markdown
# Mini DevOps Project

## Description
This project demonstrates a CI/CD pipeline using Jenkins, Docker, and CMake for a C++ calculator application.

## Features
- Menu-based calculator (Add, Subtract, Multiply, Divide)
- Automated testing
- Docker containerization
- Jenkins CI/CD pipeline

## Tools Used
- GitHub
- Jenkins
- Docker
- CMake
- C++

## Pipeline Flow
GitHub → Jenkins → Build → Test → Docker → Run
```