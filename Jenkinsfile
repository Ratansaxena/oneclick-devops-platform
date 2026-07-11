pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Project Info') {
            steps {
                sh '''
                echo "Current Directory:"
                pwd

                echo "Files:"
                ls -la
                '''
            }
        }

        stage('Terraform') {
            steps {
                sh 'ls terraform || true'
            }
        }

        stage('Docker') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Done') {
            steps {
                echo "OneClick DevOps Platform Demo Successful"
            }
        }
    }
}