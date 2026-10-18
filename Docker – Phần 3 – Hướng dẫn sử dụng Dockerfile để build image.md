# Docker – Phần 3: Hướng Dẫn Sử Dụng Dockerfile Để Build Image

Chủ đề tiếp theo trong chuỗi bài viết về Docker sẽ tập trung vào **Dockerfile** — công cụ quan trọng giúp bạn tự định nghĩa và đóng gói ứng dụng thành một Docker Image hoàn chỉnh.

---

## 1. Dockerfile Là Gì?

**Dockerfile** là một tệp văn bản (text file) chứa danh sách các chỉ thị (instructions) tiếp nối nhau. Docker dựa vào file này để tự động thực thi các lệnh và đóng gói ứng dụng thành một **Docker Image** mới.

### Quy tắc quan trọng về tên file:
- Tên mặc định chuẩn bắt buộc là: `Dockerfile` (Viết hoa chữ **D**, không có đuôi mở rộng như `.txt` hay `.md`).

### Cấu trúc Dockerfile cơ bản:

```dockerfile
FROM alpine
LABEL maintainer="hocchudong@gmail.com"
RUN apk add --update nodejs nodejs-npm
COPY . /src
WORKDIR /src
RUN npm install
EXPOSE 8080
ENTRYPOINT ["node", "./app.js"]
```

---

## 2. Các Chỉ Thị Căn Bản Trong Dockerfile

### 2.1. `FROM`
- Tất cả các Dockerfile **bắt buộc** phải khởi đầu bằng chỉ thị `FROM`.
- Chỉ thị này xác định **Base Image** (Image nền) để từ đó xây dựng các lớp (layer) bổ sung.
- *Lưu ý:* Nếu ứng dụng chạy trên Linux, Base Image được chọn phải dựa trên một hệ điều hành Linux (ví dụ: `alpine`, `ubuntu`, `debian`).

### 2.2. `LABEL`
- Dùng để thêm thông tin mô tả (metadata) vào Image.
- Khai báo dưới dạng các cặp **Key-Value** dạng chuỗi.
- Có thể sử dụng nhiều lệnh `LABEL` trong cùng một file.

**Ví dụ:**
```dockerfile
LABEL maintainer="hocchudong@gmail.com"
LABEL version="3.1"
```

### 2.3. `RUN`
- Dùng để thực thi câu lệnh Linux trong quá trình build Image (ví dụ: cài đặt thư viện, cập nhật hệ thống).
- Mỗi lệnh `RUN` sẽ tạo ra một Layer mới đè lên lớp cơ sở.

### 2.4. `COPY`
- Copy thư mục hoặc các file cần thiết từ máy Host vào bên trong Image tại thư mục được chỉ định.
- Hành động này tạo ra một Image Layer mới.

### 2.5. `WORKDIR`
- Đặt thư mục làm việc mặc định cho các chỉ thị tiếp theo như `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD`,...
- **Không** tạo ra Image Layer mới.

**Ví dụ:**
```dockerfile
WORKDIR /src
RUN npm install
```
*Giải thích:* Lệnh `npm install` sẽ được thực thi ngay tại thư mục `/src` đã thiết lập trước đó.

### 2.6. `EXPOSE`
- Thông báo cổng mà ứng dụng lắng nghe bên trong Container.
- Đóng vai trò là **Metadata / Tài liệu ghi chú**, không tạo ra Layer mới.
- ⚠️ **Lưu ý quan trọng:** `EXPOSE` **không** tự động kết nối (port forwarding/NAT port) cổng của container ra ngoài máy Host.

**Ví dụ:**
```dockerfile
EXPOSE 8080
```

### 2.7. `ENTRYPOINT`
- Định nghĩa lệnh mặc định sẽ chạy khi Container bắt đầu khởi động.
- Thường dùng để chuẩn bị môi trường chạy dịch vụ (tạo user, gán quyền, khởi động app).

**Cú pháp:**
- *Exec form (Khuyên dùng):* `ENTRYPOINT ["executable", "param1", "param2"]`
- *Shell form:* `ENTRYPOINT command param1 param2`

> **Mối quan hệ giữa `ENTRYPOINT` và `CMD`:**
> Nếu Dockerfile khai báo cả `ENTRYPOINT` và `CMD`, giá trị trong `CMD` sẽ trở thành **tham số mặc định** truyền vào cho `ENTRYPOINT`.

### 2.8. Một Số Chỉ Thị Khác

#### `ENV`
Dùng để khai báo biến môi trường (Key-Value) cho Container.

**Cú pháp:**
```dockerfile
ENV <key>=<value> ...
```
Các biến môi trường này có thể được tái sử dụng trong các chỉ thị khác như `COPY`, `RUN`, `WORKDIR`, `EXPOSE`,...

#### `CMD`
Dùng để thiết lập câu lệnh mặc định hoặc tham số truyền vào khi khởi tạo Container. Cổng lệnh trong `CMD` có thể bị đè (override) khi chạy lệnh `docker run`.

**Cú pháp:**
```dockerfile
CMD ["executable","param1","param2"]
CMD ["param1","param2"]
CMD command param1 param2
```

**Ví dụ kết hợp:**
```dockerfile
FROM ubuntu
RUN apt-get update && apt-get install -y wget
CMD ["echo", "hocchudong"]
```

---

## 3. Thực Hành: Sử Dụng Dockerfile Để Build Image

Dưới đây là từng bước tạo và chạy một Image ứng dụng web với tên `web` và tag `latest`.

### Bước 1: Chuẩn bị mã nguồn và thực hiện Build

Di chuyển vào thư mục chứa ứng dụng và chạy lệnh `docker image build`:

```bash
cd psweb
docker image build -t web:latest .
```
*(Dấu `.` thể hiện việc lấy Dockerfile tại thư mục hiện tại để build)*

### Log chi tiết quá trình Build:

```text
Sending build context to Docker daemon  123.4kB
Step 1/8 : FROM alpine
latest: Pulling from library/alpine
540db60ca938: Already exists
Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Status: Downloaded newer image for alpine:latest
 ---> 6dbb9cc54074
Step 2/8 : LABEL maintainer="nigelpoulton@hotmail.com"
 ---> Running in e9f60d86521d
Removing intermediate container e9f60d86521d
 ---> 88ea900817d5
Step 3/8 : RUN apk add --update nodejs nodejs-npm
 ---> Running in 97eef31dafbd
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/APKINDEX.tar.gz
(1/8) Installing ca-certificates (20191127-r5)
(2/8) Installing nghttp2-libs (1.42.0-r1)
(3/8) Installing brotli-libs (1.0.9-r3)
(4/8) Installing c-ares (1.17.1-r1)
(5/8) Installing libgcc (10.2.1_pre1-r3)
(6/8) Installing libstdc++ (10.2.1_pre1-r3)
(7/8) Installing nodejs (14.16.1-r1)
(8/8) Installing npm (14.16.1-r1)
Executing busybox-1.32.1-r6.trigger
Executing ca-certificates-20191127-r5.trigger
OK: 71 MiB in 22 packages
Removing intermediate container 97eef31dafbd
 ---> f5c43037595a
Step 4/8 : COPY . /src
 ---> 48dc1c44221a
Step 5/8 : WORKDIR /src
 ---> Running in 0e7bcd1a263d
Removing intermediate container 0e7bcd1a263d
 ---> 7042343c2cc6
Step 6/8 : RUN  npm install
 ---> Running in 0294a08f831b
added 270 packages from 227 contributors and audited 271 packages in 21.061s
Removing intermediate container 0294a08f831b
 ---> 6789ff2fe587
Step 7/8 : EXPOSE 8080
 ---> Running in 152f257f6ce2
Removing intermediate container 152f257f6ce2
 ---> e6ad0b8f1c35
Step 8/8 : ENTRYPOINT ["node", "./app.js"]
 ---> Running in ab0915f2acfc
Removing intermediate container ab0915f2acfc
 ---> df8dcd620c0c
Successfully built df8dcd620c0c
Successfully tagged web:latest
```

### Bước 2: Kiểm tra danh sách Image

```bash
root@dockersrv:~/psweb# docker image ls
```

**Kết quả:**
```text
REPOSITORY         TAG          IMAGE ID          CREATED          SIZE
web                latest       b0e41055ddb3      10 minutes ago   93.5MB
```

### Bước 3: Khởi chạy Container từ Image vừa tạo

Chạy container dưới dạng ngầm (`-d`), đặt tên là `web1` và ánh xạ cổng `80` trên máy Host tới cổng `8080` của Container:

```bash
docker container run -d --name web1 \
  -p 80:8080 \
  web:latest
```

Sau khi chạy xong, mở trình duyệt web và truy cập theo đường dẫn: `http://<docker_host_ip>` để xem thành quả.

---

## 4. Tổng Kết

Trong bài viết này, chúng ta đã nắm được khái niệm về Dockerfile, cách hoạt động của các chỉ thị phổ biến (`FROM`, `RUN`, `COPY`, `WORKDIR`, `EXPOSE`, `ENTRYPOINT`, `CMD`, `ENV`) và quy trình hoàn chỉnh để build một Docker Image từ mã nguồn. 

Ở bài tiếp theo, chúng ta sẽ tìm hiểu cách quản lý và triển khai ứng dụng đa dịch vụ bằng **Docker Compose**.
