FROM jupyterhub/jupyterhub:0.7.2

# install docker and python libs
RUN apt-get update --fix-missing && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://apt.dockerproject.org/gpg | apt-key add - && \
    apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    apt-key adv -k 58118E89F3A912897C070ADBF76221572C52609D && \
    mkdir -p /etc/apt/sources.list.d && \
    echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update --fix-missing && \
    apt-get -y install docker-engine=1.13.0-0~debian-jessie && \
    /opt/conda/bin/pip install \
    dockerspawner==0.6.* && \
    git clone https://github.com/shusson/oauthenticator && \
    cd oauthenticator && \
    git reset --hard d441f76 && \
    /opt/conda/bin/pip install -e .

ENV SSL_CERT=/srv/jupyterhub/secrets/jupyterhub.crt \
    SSL_KEY=/srv/jupyterhub/secrets/jupyterhub.key

COPY ./cert/*.crt $SSL_CERT
COPY ./cert/*.key $SSL_KEY
COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

RUN chmod 700 /srv/jupyterhub/secrets && \
    chmod 600 /srv/jupyterhub/secrets/*
