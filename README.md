# sam-devcontainer

## build

### manual

```shell
# amd64
devcontainer build --workspace-folder prebuild --image-name ghcr.io/alexk201/sam-devcontainer:latest --platform linux/amd64 --cache-from ghcr.io/alexk201/sam-devcontainer

# arm64
devcontainer build --workspace-folder prebuild --image-name ghcr.io/alexk201/sam-devcontainer:latest --platform linux/arm64 --cache-from ghcr.io/alexk201/sam-devcontainer
```