FROM ghcr.io/actions/actions-runner:latest

# Switch to root to install packages
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    git \
    jq \
    yq \
    unzip \
    && rm -rf /var/lib/apt/lists/*


# Install latest Java 17 LTS from Adoptium
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - && \
    echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y temurin-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/temurin-17-jdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Install latest Maven
RUN MAVEN_VERSION=$(curl -s https://maven.apache.org/download.cgi | grep -oP 'Apache Maven \K[0-9.]+' | head -1) && \
    wget https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /usr/local/maven && \
    ln -s /usr/local/maven/bin/mvn /usr/bin/mvn && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Set Maven environment variables
ENV MAVEN_HOME /usr/local/maven
ENV PATH $PATH:$MAVEN_HOME/bin

# Install yq
RUN VERSION=v4.40.5 && \
    BINARY=yq_linux_amd64 && \
    wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz -O - |\
    tar xz && mv ${BINARY} /usr/bin/yq \

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install Flux CLI
RUN curl -s https://fluxcd.io/install.sh | bash

# Verify installations
RUN java -version && mvn -version && git --version && flux -v && kubectl version --client=true

# Switch back to the default user
USER runner
