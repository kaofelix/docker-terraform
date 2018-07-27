FROM alpine

ENTRYPOINT ["/usr/local/bin/terraform"]
WORKDIR /workdir

ENV TERRAFORM_VERSION=0.11.7
ENV MONGO_ATLAS_PROVIDER_VERSION="v0.6.1"
ENV TF_HOME="/terraform"

RUN apk add --no-cache curl unzip \
 && curl --silent -L -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
 && unzip terraform.zip -d /usr/local/bin/ \
 && chmod 0755 /usr/local/bin/terraform \
 && addgroup -g 2000 -S terraform \
 && adduser -S -G terraform -u 2001 -s /bin/bash -h ${TF_HOME} terraform \
 && mkdir -p ${TF_HOME}/.terraform.d/plugins \
 && curl -L "https://github.com/akshaykarle/terraform-provider-mongodbatlas/releases/download/${MONGO_ATLAS_PROVIDER_VERSION}/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" \
    > "${TF_HOME}/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" \
 && unzip "${TF_HOME}/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" -d ${TF_HOME} \
 && mv "${TF_HOME}/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64" ${TF_HOME}/.terraform.d/plugins/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}

USER terraform
