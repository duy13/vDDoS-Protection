# Docker image for vDDoS Proxy Protection

https://github.com/duy13/vDDoS-Protection

## Usage example

### Proxying a host application

Consider an application running on host at 127.0.0.1:8000 to be reach via the
vddos proxy container at example.local:80.

1. Add `example.local` host name
For example in your `/etc/hosts`.

2. Insert setup in a file `website.conf` as follow:
```
# Website       Listen            Backend               Cache  Security  SSL-Prikey  SSL-CRTkey
example.local       http://0.0.0.0:80 http://127.0.0.1:8000 no     no       no          no
```

3. Execute vddos container:
```
$ docker run --rm --network="host" -v "$PWD/website.conf:/vddos/conf.d/website.conf" trepmag/vddos:latest
```

4. Check:
```
curl http://example.local
...
```
