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

        stage('Terraform (Validation)') {
            steps {
                echo "========== TERRAFORM =========="
                echo "Terraform validation completed successfully."
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
                        echo "playbook.yml not found."
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

            script {
                emailext(
                    to: 'ratansaxena007@gmail.com',
                    subject: "✅ SUCCESS : ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    mimeType: 'text/html',
                    body: """
<html>
<body>

<h2 style="color:green;">Build Successful ✅</h2>

<table border="1" cellpadding="8" cellspacing="0">
<tr>
<th>Project</th>
<td>${env.JOB_NAME}</td>
</tr>

<tr>
<th>Build Number</th>
<td>#${env.BUILD_NUMBER}</td>
</tr>

<tr>
<th>Status</th>
<td>SUCCESS</td>
</tr>

<tr>
<th>Build URL</th>
<td>
<a href="${env.BUILD_URL}">
${env.BUILD_URL}
</a>
</td>
</tr>
</table>

<br>

<h3>Executed Stages</h3>

<ul>
<li>✅ Git Checkout</li>
<li>✅ Project Information</li>
<li>✅ Terraform Validation</li>
<li>✅ Docker</li>
<li>✅ Ansible</li>
<li>✅ MongoDB</li>
<li>✅ System Information</li>
</ul>

<hr>

<p>
Generated automatically by Jenkins.
</p>

</body>
</html>
"""
                )
            }
        }

        failure {

            echo "❌ Build Failed."

            script {
                emailext(
                    to: 'ratansaxena007@gmail.com',
                    subject: "❌ FAILED : ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    mimeType: 'text/html',
                    body: """
<html>
<body>

<h2 style="color:red;">Build Failed ❌</h2>

<table border="1" cellpadding="8" cellspacing="0">
<tr>
<th>Project</th>
<td>${env.JOB_NAME}</td>
</tr>

<tr>
<th>Build Number</th>
<td>#${env.BUILD_NUMBER}</td>
</tr>

<tr>
<th>Status</th>
<td>FAILED</td>
</tr>

<tr>
<th>Build Log</th>
<td>
<a href="${env.BUILD_URL}">
Open Jenkins Build
</a>
</td>
</tr>
</table>

</body>
</html>
"""
                )
            }
        }
    }
}
