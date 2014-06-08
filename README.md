dockerui-auth
=============

Dockerui secured with nginx basic authorization. It is based on [crosbymichael/dockerui](https://github.com/crosbymichael/dockerui) image.


## Default configuration
Default credentials are `dockerui:dockerui`.
Nginx is running on ports `80` and `443`.

## Running a container

```
docker run -d -p 9000:443 -v /var/run/docker.sock:/var/run/docker.sock alexerm/dockerui-auth
```

To access web ui open `https://<docker_ip>:9000` in your browser

## Changing configuration

Create folder on your host machine to store configuration for dockerui container. Lets assume its path `~/dockerui`

### Authorization

1. Create your own `.htpasswd` file at dockerui folder (e.g. ~/dockerui/.htpasswd)
2. Generate new credentials
	- via `htpasswd` shell command
	```
	htpasswd -c ~/dockerui/.htpasswd [username]
	```
	- or via one of these websites [htpasswd generators](http://goo.gl/yLfKmV) (opens google search)

3. Run dockerui container with additional parameter `-v ~/dockerui/.htpasswd:/app/.htpasswd`

### Replace SSL certificates

1. Create folder for SSL certificates inside dockerui folder `~/dockerui/ssl`
2. Generate new certificates
	```
	openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Unknown/L=Unknown/O=Dis/CN=localhost" -keyout ~/dockerui/ssl/server.key  -out ~/dockerui/ssl/server.crt
	```
	**PLEASE NOTE: Key and certificate file names (`server.key` and `server.crt`) should not be changed**

3. Run dockerui with additional parameter `-v ~/dockerui/ssl:/etc/nginx/ssl`