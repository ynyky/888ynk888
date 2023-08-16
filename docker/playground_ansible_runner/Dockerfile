ARG CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX

FROM  ${CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX}python:3.10

ADD requirements.txt .

RUN apt-get update && \
    apt-get install -y sshpass python3-apt moreutils && \
    apt-get autoremove --yes && \
    apt-get clean autoclean


RUN pip install --upgrade pip wheel setuptools && \
    pip install -r requirements.txt && \
    rm -r /root/.cache

CMD ["cat"]
