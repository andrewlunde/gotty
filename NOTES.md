# After upgrading docker, might have to...
```
docker buildx create --use
```

# Created this branch from v1.5.0 with the following command:
```
git checkout tags/v1.5.0 -b v1.5.0-acl
```

# Switch back to main branch
```
git checkout master
```

# Switch back to main v1.5.0-acl branch
```
git checkout v1.5.0-acl
```

# Build for local testing
```
docker buildx build --platform linux/arm64 --tag alunde/gotty:v1.5.0 --load .
```

# Build and push to docker hub
```
docker buildx build --platform linux/arm64,linux/amd64 --tag alunde/gotty:v1.5.0 --output "type=registry" .
```

#First run on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-e LNCLI_RPCSERVER=ragnar:10009 \
-e LNCLI_TLSCERTPATHE="/lnd/tls.cert" \
-e LNCLI_MACAROONPATH="/lnd/data/chain/bitcoin/bitcoin/admin.macaroon" \
-v data:/data \
-v lnd-data:/lnd:ro \
-p 8080:8080 \
--name gotty \
-it alunde/gotty:v1.5.0
```
#Subsequent runs on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-v data:/data \
-p 8080:8080 \
-it alunde/gotty:v1.5.0
```

# Inspect
```sh
docker exec -it gotty /bin/bash
```
# Clean up
```sh
docker stop gotty
docker rm gotty
```
