stage('Terraform Format') {
    steps {
        sh '''
        echo "========== TERRAFORM FORMAT =========="
        cd terraform
        terraform fmt -check || true
        '''
    }
}

stage('Terraform Init') {
    steps {
        sh '''
        echo "========== TERRAFORM INIT =========="
        cd terraform
        terraform init
        '''
    }
}

stage('Terraform Plan') {
    steps {
        sh '''
        echo "========== TERRAFORM PLAN =========="
        cd terraform
        terraform plan || true
        '''
    }
}

stage('Terraform Apply') {
    steps {
        sh '''
        echo "========== TERRAFORM APPLY =========="
        echo "Demo Mode - Apply Skipped"
        '''
    }
}
