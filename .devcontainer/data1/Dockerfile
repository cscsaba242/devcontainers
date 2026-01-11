FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Always run as root for installing packages
USER root

# Avoid interactive prompts
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ARG JAVA_TOOL_OPTIONS

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    http_proxy=${HTTP_PROXY} \
    https_proxy=${HTTPS_PROXY} \
    no_proxy=${NO_PROXY} \
    HTTP_PROXY=${HTTP_PROXY} \
    HTTPS_PROXY=${HTTPS_PROXY} \
    NO_PROXY=${NO_PROXY} \
    JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS} \
    SDKMAN_DIR=/usr/local/sdkman \
    MAVEN_HOME=/usr/local/sdkman/candidates/maven/current \
    JAVA_HOME=/usr/local/sdkman/candidates/java/current \
    PATH=/usr/local/sdkman/candidates/java/current/bin:/usr/local/sdkman/candidates/maven/current/bin:$PATH

COPY postCreateCommand.sh /tmp/postCreateCommand.sh
RUN chmod +x /tmp/postCreateCommand.sh && /tmp/postCreateCommand.sh