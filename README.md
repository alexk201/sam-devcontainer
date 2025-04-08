# sam-devcontainer

## build

### manual

```shell
devcontainer build --workspace-folder prebuild --image-name ghcr.io/alexk201/sam-devcontainer:latest --platform linux/amd64,linux/arm64 --output type=oci,dest=output.tar --cache-from ghcr.io/alexk201/sam-devcontainer:latest --cache-from ghcr.io/alexk201/sam-devcontainer
```