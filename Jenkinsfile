pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo "========== CHECKOUT =========="
                checkout scm
            }
        }

        stage('Project Info') {
            steps {
                sh '''
                echo "========== PROJECT INFO =========="
                echo "Current Directory:"
                pwd

                echo ""
                echo "Project Files:"
                ls -la
                '''
            }
        }

        stage('Terraform') {
            steps {
                sh '''
                echo "========== TERRAFORM =========="
                if [ -d terraform ]; then
                    cd terraform
                    terraform --version
                    terraform init || true
                    terraform validate || true
                else
                    echo "Terraform folder not found."
                fi
                '''
            }
        }

        stage('Docker') {
            steps {
                sh '''
                echo "========== DOCKER =========="
                docker --version
                docker ps
                '''
            }
        }

        stage('Ansible') {
            steps {
                sh '''
                echo "========== ANSIBLE =========="
                cd ansible
                ansible-playbook -i inventory.ini playbook.yml
                '''
            }
        }

        stage('MongoDB') {
            steps {
                sh '''
                echo "========== MONGODB =========="
                docker ps | grep mongo || echo "MongoDB container not running"
                '''
            }
        }

        stage('System Info') {
            steps {
                sh '''
                echo "========== SYSTEM INFO =========="
                hostname
                whoami
                uptime
                free -h
                df -h
                '''
            }
        }

        stage('Done') {
            steps {
                echo "====================================="
                echo " OneClick DevOps Platform Demo Successful "
                echo "====================================="
            }
        }
    }

    post {
        always {
            echo "Pipeline Finished."
        }

        success {
            echo "Build Successful."
        }

        failure {
            echo "Build Failed."
        }
    }
}
