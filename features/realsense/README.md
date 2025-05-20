# RealSense Devcontainer Feature

Enable support for **Intel RealSense** cameras inside Ubuntu- or Debian-based devcontainers.  
Based on the [Official Intel RealSense SDK](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md).

---

## ⚙️ What it does

- Installs `librealsense2` from Intel’s apt repository
- Prepares your container environment for RealSense development

---

## ❗ Important Notes

- Intel officially supports only **Ubuntu 18.04, 20.04, and 22.04** - other versions (e.g. Ubuntu 24.04, Debian) *might work*, but are **not guaranteed**.
- The `librealsense2-dkms` package (which provides kernel modules) is:
  - ❌ **Not available for `arm64`**
  - 🧪 Still under evaluation - it's unclear if it's **required** or just a **helpful enhancement**

---

## ⚙️ How to use

Add this feature to your `devcontainer.json`:

```json
"features": {
    "sam-dev.cs.hm.edu:5023/sam-dev/sam-devcontainer/realsense:latest": {}
}
````

---

## 🧰 USB Access Tips

To use RealSense cameras inside your container, make sure USB devices are accessible.  
This may require additional Docker runtime options or host configuration depending on your setup.

Common approaches include:

- Passing USB devices to the container (e.g., `--device=/dev/bus/usb`)
- Running the container with elevated privileges (`--privileged`)
- Ensuring the container user has permissions to access USB devices (e.g., part of `video` or `plugdev` groups)

Check your container runtime and host OS documentation for details on enabling USB device access.
