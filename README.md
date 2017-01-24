## JupyterHub Docker deployment

## Installation

- create .env file
```bash
export AUTH0_SUBDOMAIN="beans"
export OAUTH_CLIENT_ID="BEANS"
export OAUTH_CLIENT_SECRET="super secret beans"
export OAUTH_CALLBACK_URL="https://beans/hub/oauth_callback"
export COMPOSE_PROJECT_NAME=jhubsgc
```

- modify `jupyrerhub_config.py` with your own config

- create cert files (or use your own)
```bash
mkdir cert && cd cert
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout jupyterhub.key -out jupyterhub.crt
```

- pull thebe-hail image
```bash
docker pull shusson/thebe-hail:1.0
```

- source the env and run docker compose
```bash
source .env
docker-compose up
```
