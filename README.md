# sam-devcontainer

A curated collection of devcontainer features used by **SAM ROS 2**.  
Features are organized under the `features/` directory, and prebuilt configurations are stored in the `prebuild/` directory.

Each feature is self-contained and includes detailed documentation within its respective folder.

⚠️ **Important:**
When updating a feature, **always increment its version number**, ideally following [Semantic Versioning (SemVer)](https://semver.org/). The DevContainer CLI skips publishing if a version tag already exists.
Re-publishing an existing version requires manually deleting the tag from the container registry which is strongly discouraged.

---

## 📦 Available Features

| Feature     | Purpose                                  |
|-------------|-------------------------------------------|
| `caret`     | Adds [CARET](https://tier4.github.io/caret_doc/main/) tooling for ROS performance analysis |
| `clangd`    | Installs the **clangd** language server for enhanced C/C++ code completion, navigation, and diagnostics |
| `cuda`      | Installs **CUDA**, **cuDNN**, and **TensorRT** for object detection. Versions are selected for compatibility with **Pascal-based GPUs** (e.g. GTX 1050Ti),  such as those used in the **AADC car** project. |
| `pylon`     | Adds support for Basler Pylon cameras     |
| `realsense` | Adds support for Intel RealSense cameras  |
| `ros`       | Automatically installs ROS 2 based on Ubuntu version |
| `utility`   | Container utilities for updating system components during build |

⚠️ Currently, these features only support **Debian-based** distributions via `apt`.

---

## 🔧 Build

The build process is automated using a GitLab CI pipeline, but you can also build manually:

### 🛠️ Manual Build

```bash
# publish to sam-devcontainer
CI_REGISTRY_IMAGE=sam-dev.cs.hm.edu:5023/sam-dev/sam-devcontainer

# publish to ros2/sam-devcontainer (main repo)
CI_REGISTRY_IMAGE=sam-dev.cs.hm.edu:5023/sam-dev/ros2/sam-devcontainer

# for amd64
devcontainer build \
  --workspace-folder prebuild \
  --image-name $CI_REGISTRY_IMAGE:amd64 \
  --platform linux/amd64

# for arm64
devcontainer build \
  --workspace-folder prebuild \
  --image-name $CI_REGISTRY_IMAGE:arm64 \
  --platform linux/arm64

# manually create one "latest" manifest that refereces both images
docker manifest create $CI_REGISTRY_IMAGE:latest $CI_REGISTRY_IMAGE:amd64 $CI_REGISTRY_IMAGE:arm64
docker manifest annotate $CI_REGISTRY_IMAGE:latest $CI_REGISTRY_IMAGE:amd64 --os linux --arch amd64
docker manifest annotate $CI_REGISTRY_IMAGE:latest $CI_REGISTRY_IMAGE:arm64 --os linux --arch arm64
docker manifest push $CI_REGISTRY_IMAGE:latest
````

---

## 🚀 Publish Features

```bash
docker login sam-dev.cs.hm.edu:5023 -u sam-devcontainer -p <redacted>
# or
export DEVCONTAINERS_OCI_AUTH="sam-dev.cs.hm.edu:5023|sam-devcontainer|<redacted>"

devcontainer features publish \
  -r sam-dev.cs.hm.edu:5023 \
  -n sam-dev/sam-devcontainer/features \
  features
```