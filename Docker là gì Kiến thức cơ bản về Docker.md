# Tại sao phải dùng Docker?

Việc setup và deploy application lên một hoặc nhiều server rất vất vả từ việc phải cài đặt các công cụ, môi trường cần cho application đến việc chạy được ứng dụng chưa kể việc không đồng nhất giữa các môi trường trên nhiều server khác nhau. Chính vì lý do đó Docker được ra đời để giải quyết vấn đề này.

# Docker là gì?

Docker là nền tảng phần mềm cho phép bạn dựng, kiểm thử và triển khai ứng dụng một cách nhanh chóng. Docker đóng gói phần mềm vào các đơn vị tiêu chuẩn hóa được gọi là container có mọi thứ mà phần mềm cần để chạy, trong đó có thư viện, công cụ hệ thống, mã và thời gian chạy. Bằng cách sử dụng Docker, bạn có thể nhanh chóng triển khai và thay đổi quy mô ứng dụng vào bất kỳ môi trường nào và biết chắc rằng mã của bạn sẽ chạy được.

# Lợi ích của Docker

- Không như máy ảo Docker start và stop chỉ trong vài giây.
- Bạn có thể khởi chạy container trên mỗi hệ thống mà bạn muốn.
- Container có thể build và loại bỏ nhanh hơn máy ảo.
- Dễ dàng thiết lập môi trường làm việc. Chỉ cần config 1 lần duy nhất và không bao giờ phải cài đặt lại các dependencies. Nếu bạn thay đổi máy hoặc có người mới tham gia vào project thì bạn chỉ cần lấy config đó và đưa cho họ.
- Nó giữ cho word-space của bạn sạch sẽ hơn khi bạn xóa môi trường mà ảnh hưởng đến các phần khác.

# Cài đặt

Link download: tại đây

Chọn bản cài đặt tương ứng với hệ điều hành của bạn và tiến hành cài đặt theo hướng dẫn đối với Linux còn Windows và MacOS thì bạn chỉ cần tải bản cài về và cài đặt như mọi application khác.

Sau khi cài đặt xong để kiểm tra xem cài đặt thành công hay không ?
- Mở command line:

```bash
$ docker version
$ docker info
$ docker run hello-world
```

# Một số khái niệm

- Docker Client: là cách mà bạn tương tác với docker thông qua command trong terminal. Docker Client sẽ sử dụng API gửi lệnh tới Docker Daemon.
- Docker Daemon: là server Docker cho yêu cầu từ Docker API. Nó quản lý images, containers, networks và volume.
- Docker Volumes: là cách tốt nhất để lưu trữ dữ liệu liên tục cho việc sử dụng và tạo apps.
- Docker Registry: là nơi lưu trữ riêng của Docker Images. Images được push vào registry và client sẽ pull images từ registry. Có thể sử dụng registry của riêng bạn hoặc registry của nhà cung cấp như : AWS, Google Cloud, Microsoft Azure.
- Docker Hub: là Registry lớn nhất của Docker Images ( mặc định). Có thể tìm thấy images và lưu trữ images của riêng bạn trên Docker Hub ( miễn phí).
- Docker Repository: là tập hợp các Docker Images cùng tên nhưng khác tags. VD: golang:1.11-alpine.
- Docker Networking: cho phép kết nối các container lại với nhau. Kết nối này có thể trên 1 host hoặc nhiều host.
- Docker Compose: là công cụ cho phép run app với nhiều Docker containers 1 cách dễ dàng hơn. Docker Compose cho phép bạn config các command trong file docker-compose.yml để sử dụng lại. Có sẵn khi cài Docker.
- Docker Swarm: để phối hợp triển khai container.
- Docker Services: là các containers trong production. 1 service chỉ run 1 image nhưng nó mã hoá cách thức để run image — sử dụng port nào, bao nhiêu bản sao container run để service có hiệu năng cần thiết và ngay lập tức.

# Dockerfile

– Dockerfile là file config cho Docker để build ra image. Nó dùng một image cơ bản để xây dựng lớp image ban đầu. Một số image cơ bản: python, unbutu and alpine. Sau đó nếu có các lớp bổ sung thì nó được xếp chồng lên lớp cơ bản. Cuối cùng một lớp mỏng có thể được xếp chồng lên nhau trên các lớp khác trước đó.

– Các config :
- FROM — chỉ định image gốc: python, unbutu, alpine…
- LABEL — cung cấp metadata cho image. Có thể sử dụng để add thông tin maintainer. Để xem các label của images, dùng lệnh docker inspect.
- ENV — thiết lập một biến môi trường.
- RUN — Có thể tạo một lệnh khi build image. Được sử dụng để cài đặt các package vào container.
- COPY — Sao chép các file và thư mục vào container.
- ADD — Sao chép các file và thư mục vào container.
- CMD — Cung cấp một lệnh và đối số cho container thực thi. Các tham số có thể được ghi đè và chỉ có một CMD.
- WORKDIR — Thiết lập thư mục đang làm việc cho các chỉ thị khác như: RUN, CMD, ENTRYPOINT, COPY, ADD,…
- ARG — Định nghĩa giá trị biến được dùng trong lúc build image.
- ENTRYPOINT — cung cấp lệnh và đối số cho một container thực thi.
- EXPOSE — khai báo port lắng nghe của image.
- VOLUME — tạo một điểm gắn thư mục để truy cập và lưu trữ data.

# Tạo Demo

Tạo file Dockerfile

```dockerfile
FROM golang:1.11 AS builder
WORKDIR /go/src/docker-demo/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o docker-demo .

FROM alpine:latest
WORKDIR /root/
COPY — from=builder /go/src/docker-demo .
CMD [“./docker-demo”]
```

Tạo file main.go

```go
package main

import (
   “fmt”
)

func main() {
   fmt.Println(“Learning Docker”)
}
```

Tiến hành build file Dockerfile

```bash
$ docker build .

$ docker run 4cc010d9d657
```

Kết quả in ra dòng chữ Learning Docker đã được code trong file main.go

# Các lênh cơ bản trong docker

- List image/container:
```bash
$ docker image/container ls
```
- Delete image/container:
```bash
$ docker image/container rm <tên image/container >
```
- Delete all image hiện có:
```bash
$ docker image rm $(docker images –a –q)
```
- List all container hiện có:
```bash
$ docker ps –a
```
- Stop a container cụ thể:
```bash
$ docker stop <tên container>
```
- Run container từ image và thay đổi tên container:
```bash
$ docker run –name <tên container> <tên image>
```
- Stop all container:
```bash
$ docker stop $(docker ps –a –q)
```
- Delete all container hiện có:
```bash
$ docker rm $(docker ps –a –q)
```
- Show log a container:
```bash
$ docker logs <tên container>
```
- Build một image từ container:
```bash
$ docker build -t <tên container> .
```
- Tạo một container chạy ngầm:
```bash
$ docker run -d <tên image>
```
- Tải một image trên docker hub:
```bash
$ docker pull <tên image>
```
- Start một container:
```bash
$ docker start <tên container>
```
