FROM alpine

ENTRYPOINT ["/usr/local/bin/terraform"]
WORKDIR /workdir

ENV TERRAFORM_VERSION=0.11.7
ENV MONGO_ATLAS_PROVIDER_VERSION="v0.6.1"

RUN apk add --no-cache curl unzip \
 && curl --silent -L -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
 && unzip terraform.zip -d /usr/local/bin/ \
 && chmod 0755 /usr/local/bin/terraform \
 && mkdir -p ~/.terraform.d/plugins \
 && curl -L "https://github.com/akshaykarle/terraform-provider-mongodbatlas/releases/download/${MONGO_ATLAS_PROVIDER_VERSION}/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" \
    > "terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" \
 && unzip "terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64.zip" \
 && mv "./terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}_linux_amd64" ~/.terraform.d/plugins/terraform-provider-mongodbatlas_${MONGO_ATLAS_PROVIDER_VERSION}

USER nobody
