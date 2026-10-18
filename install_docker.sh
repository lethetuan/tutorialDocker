#!/bin/bash

# ==============================================================================
# Script cài đặt Docker Engine & Docker Compose v5 (Mới nhất)
# Hỗ trợ: Ubuntu / Debian / CentOS / RHEL / AlmaLinux / Rocky Linux
# ==============================================================================

set -e # Dừng script ngay nếu gặp lỗi

# 1. Kiểm tra quyền Root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Vui lòng chạy script bằng quyền root hoặc sudo: sudo bash $0"
    exit 1
fi

# 2. Nhận diện Hệ điều hành
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Không thể xác định hệ điều hành."
    exit 1
fi

echo "🔍 Đang khởi tạo cài đặt trên OS: $OS"

# 3. Cài đặt Docker Engine từ Repositories chính thức
install_docker_engine() {
    case "$OS" in
        ubuntu|debian)
            echo "🔄 Cập nhật và cài đặt Docker Engine cho Ubuntu/Debian..."
            apt-get update -y
            apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
            apt-get install -y ca-certificates curl gnupg lsb-release git

            install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/$OS/gpg -o /etc/apt/keyrings/docker.asc
            chmod a+r /etc/apt/keyrings/docker.asc

            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$OS \
              $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
              tee /etc/apt/sources.list.d/docker.list > /dev/null

            apt-get update -y
            apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
            ;;
        centos|rhel|almalinux|rocky)
            echo "🔄 Cập nhật và cài đặt Docker Engine cho RHEL/CentOS..."
            yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-engine 2>/dev/null || true
            yum install -y yum-utils git curl
            yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
            ;;
        *)
            echo "❌ Hệ điều hành '$OS' chưa được hỗ trợ."
            exit 1
            ;;
    esac
}

install_docker_engine

# 4. Tải & Cài đặt Docker Compose v5 (Mới nhất từ GitHub Releases)
echo "⚡ Đang kiểm tra và tải phiên bản Docker Compose v5 mới nhất..."

# Tự động lấy tag phiên bản v5 mới nhất từ GitHub
COMPOSE_V5_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases | grep -oE '"tag_name": "v5\.[0-9]+\.[0-9]+"' | head -n 1 | cut -d '"' -f 4)

if [ -z "$COMPOSE_V5_VERSION" ]; then
    echo "⚠️ Không lấy được tag tự động, sẽ dùng fallback bản v5 mặc định."
    COMPOSE_V5_VERSION="v5.6.0"
fi

echo "📦 Phiên bản Compose v5 tìm thấy: $COMPOSE_V5_VERSION"

# Tạo thư mục CLI plugin chuẩn của Docker
PLUGIN_DIR="/usr/local/lib/docker/cli-plugins"
mkdir -p "$PLUGIN_DIR"

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  CLI_ARCH="x86_64" ;;
    aarch64) CLI_ARCH="aarch64" ;;
    armv7l)  CLI_ARCH="armv7" ;;
    *) echo "❌ Kiến trúc $ARCH không hỗ trợ"; exit 1 ;;
esac

OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')

# Tải binary Docker Compose v5 về làm CLI Plugin
DOWNLOAD_URL="https://github.com/docker/compose/releases/download/${COMPOSE_V5_VERSION}/docker-compose-${OS_TYPE}-${CLI_ARCH}"

echo "⬇️ Đang tải từ: $DOWNLOAD_URL"
curl -L "$DOWNLOAD_URL" -o "$PLUGIN_DIR/docker-compose"
chmod +x "$PLUGIN_DIR/docker-compose"

# Cấu hình Alias/Link để gõ được cả 2 lệnh: 'docker compose' lẫn 'docker-compose'
ln -sf "$PLUGIN_DIR/docker-compose" /usr/local/bin/docker-compose

# 5. Khởi động Docker Service
echo "⚙️ Đang bật Docker Service..."
systemctl enable docker
systemctl start docker

# 6. Thêm User hiện tại vào Group 'docker' (chạy không cần sudo)
SUDO_USER_NAME=${SUDO_USER:-$USER}
if [ "$SUDO_USER_NAME" != "root" ]; then
    usermod -aG docker "$SUDO_USER_NAME"
fi

# 7. Kiểm tra kết quả
echo ""
echo "=================================================="
echo "✔️ KIỂM TRA PHIÊN BẢN ĐÃ CÀI ĐẶT:"
docker --version
docker compose version
docker-compose --version
echo "=================================================="

if docker run --rm hello-world | grep -q "Hello from Docker!"; then
    echo ""
    echo "🎉 CÀI ĐẶT THÀNH CÔNG DOCKER & DOCKER COMPOSE $COMPOSE_V5_VERSION!"
    if [ "$SUDO_USER_NAME" != "root" ]; then
        echo "💡 Hãy gõ lệnh 'newgrp docker' (hoặc Đăng xuất / Đăng nhập lại) để dùng Docker mà không cần 'sudo'."
    fi
else
    echo "❌ Cài đặt chưa hoàn tất thành công, vui lòng kiểm tra lại dịch vụ Docker."
    exit 1
fi
