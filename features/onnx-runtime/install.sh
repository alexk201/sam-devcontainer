ONNXRUNTIME_VERSION=${VERSION:-1.22.0}

SYSTEM_ARCHITECTURE=$(uname -m)

# Determine ONNX Runtime architecture
case "$SYSTEM_ARCHITECTURE" in
aarch64|arm64)
    ONNXRUNTIME_BASE_NAME="onnxruntime-linux-aarch64-${ONNXRUNTIME_VERSION}"
    ;;
x86_64)
    ONNXRUNTIME_BASE_NAME="onnxruntime-linux-x64-gpu-${ONNXRUNTIME_VERSION}"
    ;;
*)
    echo "Unsupported architecture: $SYSTEM_ARCHITECTURE"
    exit 1
    ;;
esac

ONNXRUNTIME_URL="https://github.com/microsoft/onnxruntime/releases/download/v${ONNXRUNTIME_VERSION}/${ONNXRUNTIME_BASE_NAME}.tgz"

# Function to download and extract ONNX Runtime
download_onnxruntime() {
    echo "Downloading ONNX Runtime from $ONNXRUNTIME_URL ..."

    if ! wget -qq -O "/tmp/${ONNXRUNTIME_BASE_NAME}.tgz" "$ONNXRUNTIME_URL"; then
        echo "Error: Failed to download ONNX Runtime."
        exit 1
    fi

    echo "Extracting ONNX Runtime ..."
    if ! tar -zxvf "/tmp/${ONNXRUNTIME_BASE_NAME}.tgz" --directory "/opt/"; then
        echo "Error: Failed to extract ONNX Runtime."
        exit 1
    fi

    mv "/opt/${ONNXRUNTIME_BASE_NAME}" /opt/onnxruntime

    rm -f "/opt/${ONNXRUNTIME_BASE_NAME}.tgz"
}

# Main script execution
if [ ! -d "/opt/onnxruntime" ]; then
    download_onnxruntime
else
    echo "ONNX Runtime already exists. Skipping download."
fi