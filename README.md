# docker-dnscrypt
Establishes a local DNScrypt proxy.

# Usage

Build the image:

	docker build -t dnscrypt-proxy .

Start the container:

	docker run -d -p 127.0.0.1:53:53/udp dnscrypt-proxy

The above steps will build and start the container using default settings, connecting it to dnscrypt.eu-nl server. If you would like to override this, use the following run to set variables:

	docker run -d -p 127.0.0.1:53:53/udp \
	-e RESOLVER_NAME=dnscrypt.eu-nl \
	dnscrypt-proxy
	
# Information regarding resolvers
The script fetches the latest official [dnscrypt-resolvers.csv](https://raw.githubusercontent.com/jedisct1/dnscrypt-resolvers/master/v1/dnscrypt-resolvers.csv) on every start. If your resolver key changes (typically once per year), you just need to restart the container to re-establish a connection using the new key.

# Credit

The Dockerfile in this project is based on [dnscrypt-server-docker](https://github.com/jedisct1/dnscrypt-server-docker) and the basic idea of [dnscryptio/dnscrypt-proxy-docker](https://github.com/dnscryptio/dnscrypt-proxy-docker)
