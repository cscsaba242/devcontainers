FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04
USER root

# Avoid interactive prompts
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

ENV DEBIAN_FRONTEND=noninteractive
ENV http_proxy=${HTTP_PROXY} \
    https_proxy=${HTTPS_PROXY} \
    no_proxy=${NO_PROXY} \
    HTTP_PROXY=${HTTP_PROXY} \
    HTTPS_PROXY=${HTTPS_PROXY} \
    NO_PROXY=${NO_PROXY}

# Versions (easy to bump later)
ARG HELM_VERSION=v3.12.0
ARG KUBECTL_VERSION=v1.29.0
ARG KIND_VERSION=v0.23.0

# Install dependencies + tools
RUN apt-get update \
    && apt-get install -y docker.io --no-install-recommends \
        curl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    \
    && echo "Installing helm" \
    && curl -fsSL -o /tmp/helm.tar.gz \
        https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && rm -rf /tmp/linux-amd64 /tmp/helm.tar.gz \
    \
    && echo "Installing kubectl" \
    && curl -fsSLo /usr/local/bin/kubectl \
        https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    \
    && echo "Installing kind" \
    && curl -fsSLo /usr/local/bin/kind \
        https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64 \
    && chmod +x /usr/local/bin/kind \
    \
    && echo "Verify installs" \
    && helm version \
    && kubectl version --client \
    && kind version
