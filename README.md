# docker-dnscrypt
Establishes a local DNScrypt proxy.

# Usage
By default this container is connecting to dnscrypt.eu-nl server. To change this, just set the RESOLVER_NAME variable:

```
docker run -d \
  --name="DNScrypt" \
  -p 53:53/udp \
  -e RESOLVER_NAME=dnscrypt.eu-nl \
  rix1337/docker-dnscrypt
```
	
# Information regarding resolvers
The script fetches the latest official [dnscrypt-resolvers.csv](https://raw.githubusercontent.com/jedisct1/dnscrypt-resolvers/master/v1/dnscrypt-resolvers.csv) on every start. If your resolver key changes (typically once per year), you just need to restart the container to re-establish a connection using the new key.

# Credit

The Dockerfile in this project is based on [dnscrypt-server-docker](https://github.com/jedisct1/dnscrypt-server-docker) and the basic idea of [dnscryptio/dnscrypt-proxy-docker](https://github.com/dnscryptio/dnscrypt-proxy-docker)
