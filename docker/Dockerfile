FROM jenkins/jenkins:lts-jdk21

USER root

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    wget \
    gnupg \
    ca-certificates \
    lsb-release \
    apt-transport-https \
    ansible \
    docker.io

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip && \
    unzip terraform_1.9.8_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.9.8_linux_amd64.zip

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

USER jenkins
