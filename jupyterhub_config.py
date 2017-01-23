import os

c.JupyterHub.authenticator_class = 'oauthenticator.auth0.Auth0OAuthenticator'

c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.DockerSpawner.container_image = 'shusson/jspawn'

network_name = os.environ['COMPOSE_PROJECT_NAME'] + '_default'
c.DockerSpawner.network_name = network_name
c.DockerSpawner.extra_host_config = { 'network_mode': network_name }
c.DockerSpawner.use_internal_ip = True
c.DockerSpawner.notebook_dir = '/home/jovyan/work'
c.DockerSpawner.volumes = { 'jupyterhub-user-{username}': '/home/jovyan/work' }
c.DockerSpawner.extra_create_kwargs.update({ 'volume_driver': 'local' })
c.DockerSpawner.remove_containers = True
c.DockerSpawner.extra_create_kwargs.update({ 'command': 'start-singleuser.sh' })

c.JupyterHub.hub_ip = 'jupyterhub'
c.JupyterHub.hub_port = 8080

c.JupyterHub.port = 443
c.JupyterHub.ssl_key = os.environ['SSL_KEY']
c.JupyterHub.ssl_cert = os.environ['SSL_CERT']
