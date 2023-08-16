ARG CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX

FROM ${CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX}hashicorp/packer:light-1.8.3

ADD requirements.txt .

RUN apk add --update --no-cache python3 python3-dev build-base openssh-client gawk && \
    ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip



RUN pip3 install --upgrade pip wheel setuptools && \
    pip3 install -r requirements.txt && \
    rm -r /root/.cache
