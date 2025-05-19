# ROS Devcontainer Feature

Automate ROS installation inside devcontainers.  
Currently supports **Ubuntu-based** containers only.

---

## 🚀 What it does

- 🧠 Detects the Ubuntu codename
- 🔁 Selects the matching ROS distribution (e.g. *Humble* for *jammy*, *Jazzy* for *noble*)
- 🔑 Adds ROS apt repositories and GPG keys
- 📦 Installs core ROS packages and developer tools
- ⚙️ Sets environment variables and recommended locales

---

## 🐧 Supported Ubuntu & ROS versions

| Ubuntu Codename | ROS Distribution |
|-----------------|------------------|
| `jammy` (22.04) | humble           |
| `noble` (24.04) | jazzy            |

---

## ⚙️ How to use

Add the feature to your `devcontainer.json`:

```json
"features": {
    "sam-dev.cs.hm.edu:5023/sam-dev/sam-devcontainer/ros:latest": {}
}
```
