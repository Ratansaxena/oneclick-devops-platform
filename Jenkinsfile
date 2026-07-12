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

        stage('Terraform Format') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "========== TERRAFORM FORMAT =========="
                    terraform fmt -check
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "========== TERRAFORM INIT =========="
                    terraform init
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "========== TERRAFORM VALIDATE =========="
                    terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "========== TERRAFORM PLAN =========="
                    terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                    echo "========== TERRAFORM APPLY =========="
                    terraform apply -auto-approve tfplan
                    '''
                }
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
    }

    post {

        always {
            echo "====================================="
            echo "Pipeline Finished."
            echo "====================================="
        }

        success {
            echo "🎉 Build Successful."

            emailext(
                to: 'ratansaxena007@gmail.com',
                subject: "✅ SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                <h2>Build Successful ✅</h2>

                <p><b>Job:</b> ${env.JOB_NAME}</p>
                <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                <p><b>Status:</b> SUCCESS</p>

                <p><a href="${env.BUILD_URL}">Open Build</a></p>

                <hr>

                <h3>OneClick DevOps Platform</h3>

                <ul>
                  <li>✔ Checkout</li>
                  <li>✔ Project Info</li>
                  <li>✔ Terraform Format</li>
                  <li>✔ Terraform Init</li>
                  <li>✔ Terraform Validate</li>
                  <li>✔ Terraform Plan</li>
                  <li>✔ Terraform Apply</li>
                  <li>✔ Docker</li>
                  <li>✔ Ansible</li>
                  <li>✔ MongoDB</li>
                  <li>✔ System Information</li>
                </ul>

                <br>

                Jenkins Automated Email
                """
            )
        }

        failure {
            echo "❌ Build Failed."

            emailext(
                to: 'ratansaxena007@gmail.com',
                subject: "❌ FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                mimeType: 'text/html',
                body: """
                <h2>Build Failed ❌</h2>

                <p><b>Job:</b> ${env.JOB_NAME}</p>
                <p><b>Build Number:</b> ${env.BUILD_NUMBER}</p>
                <p><b>Status:</b> FAILED</p>

                <p><a href="${env.BUILD_URL}">Open Build Log</a></p>
                """
            )
        }
    }
}
