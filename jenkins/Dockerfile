FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
    docker.io \
    git \
    curl \
    wget \
    unzip \
    python3 \
    python3-pip \
    python3-venv \
    gnupg && \
    apt-get clean


# Install Ansible
RUN python3 -m venv /opt/ansible && \
    /opt/ansible/bin/pip install --upgrade pip && \
    /opt/ansible/bin/pip install ansible

ENV PATH="/opt/ansible/bin:${PATH}"

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

USER jenkins
