FROM bitnami/keycloak:latest

# Switch to root user to ensure proper permissions when copying files
USER root

# Copy the provider JAR to the Keycloak providers directory
# The providers directory might not exist by default, so we need root permissions
COPY ./keycloak/providers/*.jar /opt/bitnami/keycloak/providers/

# Ensure the copied files have the correct ownership
RUN chown -R 1001:1001 /opt/bitnami/keycloak/providers/

# Use --auto-build argument to rebuild Keycloak with the custom provider
ENV KEYCLOAK_EXTRA_ARGS="--auto-build"

# Switch back to the non-root user (Bitnami's default user)
USER 1001
