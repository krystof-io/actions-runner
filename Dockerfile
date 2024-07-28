from ghcr.io/actions/actions-runner:latest

# Switch to root to install packages
USER root

# Update package lists and install git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the default user
USER runner
