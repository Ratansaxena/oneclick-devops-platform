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

        stage('Terraform (Skipped)') {
            steps {
                echo "========== TERRAFORM =========="
                echo "Terraform validation skipped for demo."
            }
        }

        stage('Docker') {
            steps {
                sh '''
                echo "========== DOCKER =========="
                docker --version || true
                docker ps || true
                '''
            }
        }

        stage('Ansible') {
            steps {
                sh '''
                echo "========== ANSIBLE =========="

                if [ -d ansible ]; then
                    cd ansible

                    if [ -f playbook.yml ]; then
                        ansible-playbook -i inventory.ini playbook.yml || true
                    else
                        echo "playbook.yml not found. Skipping..."
                    fi
                else
                    echo "Ansible folder not found."
                fi
                '''
            }
        }

        stage('MongoDB') {
            steps {
                sh '''
                echo "========== MONGODB =========="
                docker ps | grep mongo || echo "MongoDB container not running."
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
            echo "🎉 Build Successful."
        }

        failure {
            echo "❌ Build Failed."
        }
    }
}
