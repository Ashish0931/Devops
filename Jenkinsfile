pipeline {
    agent any

    environment {
        Username = 'Ashish0931'
        token = 'dckr_pat_iQiZFqzBzepvHrX5c-b8Xm4I_Nk'
        build_number = 'V.1'
        docker_credentials = credentials('docker')
    }
    stages {
        stage('Git-checkin'){
            steps {
                git 'https://github.com/anshulc55/Jenkins_Upgradev3.git'
            
            }
        }
        stage('Build') {
            steps {
                echo '----------Building code------------'
                sh 'ls'
                sh 'dotnet build ./jenkins-plugin-model/src/Pi.Web/Pi.Web.csproj'
            }
        }
        stage('Test') {
            steps {
                echo '-------------Testing..-------------------'
                sh 'dotnet test --logger "trx;LogFileName=Pi.Math.trx" ./jenkins-plugin-model/src/Pi.Math.Tests/Pi.Math.Tests.csproj'
                sh 'dotnet test --logger "trx;LogFileName=Pi.Runtime.trx" ./jenkins-plugin-model/src/Pi.Runtime.Tests/Pi.Runtime.Tests.csproj'

            }
        }
        stage('Deploy') {
            steps {
                echo '-------------------Budiling Docker Image....---------------------'
                sh 'docker build -t $$build_number -f ./jenkins-plugin-model/src/demo2-publish/dockerfile .'
                
            }
        }
        stage('Push image') {
            steps {
                sh 'docker login -u ashish0931 -p dckr_pat_iQiZFqzBzepvHrX5c-b8Xm4I_Nk'
                sh 'docker push ashish0931/docker-practice'
            }
        }
        }
    }
