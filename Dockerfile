FROM python:3.7-slim-buster
WORKDIR /opt/CTFd
RUN mkdir -p /opt/CTFd /var/log/CTFd /var/uploads

COPY sources.list /etc/apt/
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        default-mysql-client \
        python-dev \
        libffi-dev \
        libssl-dev \
        git \
        vim \
        ssh \
        htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /opt/CTFd

RUN pip config set global.index-url  https://pypi.doubanio.com/simple

RUN pip install -r requirements.txt --no-cache-dir
# hadolint ignore=SC2086
RUN for d in CTFd/plugins/*; do \
        if [ -f "$d/requirements.txt" ]; then \
            pip install -r $d/requirements.txt --no-cache-dir; \
        fi; \
    done;

RUN useradd \
    -u 1001 \
    -s /bin/bash \
    -m -k /etc/skel \
    -G root \ 
    -p XXXXXX \
    ctfd
RUN chmod +x /opt/CTFd/docker-entrypoint.sh \
    && chown -R 1001:1001 /opt/CTFd /var/log/CTFd /var/uploads

USER 0
EXPOSE 8000
EXPOSE 22
ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
