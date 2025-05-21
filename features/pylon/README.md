# Pylon Camera Support for Devcontainers

Devcontainer feature for using **Basler Pylon cameras** inside Ubuntu-based containers.  
Supports Ubuntu 22.04 and 24.04 🎯

---

## 📦 What it does

- 🧰 Installs the Pylon camera SDK (hosted privately due to lack of an official apt repo)
- 🐧 Works on Ubuntu `jammy` (22.04) and `noble` (24.04)

---

## ⚙️ How to use

Add this feature to your `devcontainer.json`:

```json
"features": {
    "sam-dev.cs.hm.edu:5023/sam-dev/sam-devcontainer/pylon:latest": {}
}
