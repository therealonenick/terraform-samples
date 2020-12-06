FROM node:12-buster-slim

USER root

ENV PATH="/usr/lib${PATH}"

RUN apt-get update \
    && apt-get install -y \
	zip \
	unzip \
	python3-pip \
	wget \
	curl \
	git

RUN wget --quiet https://releases.hashicorp.com/terraform/TF_VERSION/terraform_TF_VERSION_linux_amd64.zip \
  && unzip terraform_TF_VERSION_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_TF_VERSION_linux_amd64.zip

ENTRYPOINT ["/bin/bash", "-c"]
