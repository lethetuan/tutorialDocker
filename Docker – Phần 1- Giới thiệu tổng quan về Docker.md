# Docker – Phần 1- Giới thiệu tổng quan về Docker

Docker giúp các developer xây dựng các container chứa các phần mềm nhẹ và di động giúp cho việc phát triển, thử nghiệm và triển khai ứng dụng một cách nhanh chóng.
Bằng cách sử dụng Docker, ta có thể nhanh chóng triển khai ứng dụng và thay đổi quy mô ứng dụng vào bất kỳ môi trường nào. Docker còn cung cấp nhiều lợi ích khác ngoài tính năng đóng gói, cách ly, tính di động và kiểm soát 1 cách tiện dụng này. Hãy cùng tìm hiểu ở bài viết này nhé.

## 1. Docker là gì?
Khi nói về docker, ta có thể đề cập đến một trong những điều sau:
- Công ty Docker, Inc
- Công nghệ Docker

Phần lớn khi nói về Docker, ta thường sẽ hiểu là Công nghệ Docker. Nó được phát triển bởi Docker, Inc và năm 2013, là một công ty công nghệ có trụ sở tại Mỹ. Nó là 1 phần mềm chạy trên Linux hoặc Windows, cho phép bạn dựng, kiểm thử và triển khai ứng dụng một cách nhanh chóng. Docker đóng gói phần mềm vào các đơn vị tiêu chuẩn hóa được gọi là container.
Docker được đặt tên xuất phát từ cách diễn đạt dock worker
Docker có 2 phiên bản chính:
- Docker Community Editon – CE: Là phiên bản miễn phí
- Docker Enterprise – EE: Phiên bản này là phiên bản trả phí, khi sử dụng phiên bản này bạn sẽ có được sự hỗ trợ từ nhà phát hành.

## 2. Chức năng, vai trò của Docker
- Docker cho phép phát triển, di chuyển và chạy các ứng dụng dựa vào công nghệ ảo hóa trong linux
- Tự động triển khai các ứng dụng bên trong các container bằng cách cung cấp thêm một lớp trừu tượng và tự động hóa việc ảo hóa mức (OS)
- Docker có thể được sử dụng trên các hệ điều hành như: Windows, Linux, MacOS.

Một số lợi ích khi sử dụng docker như:
- Docker giúp cho việc vận chuyển phần mềm nhanh hơn trung bình 7 lần so mới người dùng không sử dụng docker
- Nhanh chóng tiển khai, khởi động và di chuyển.
- Bảo mật
- Hỗ trợ APIs để giao tiếp với các container
- Việc triển khai phần mềm, khắc phục sự cố dễ dàng hơn so được đóng vào container nhỏ
- Tiết kiệm tài nguyên và tiền bạc vì nó giúp chạy nhiều phần mềm hơn trên 1 máy chủ giúp tận dụng tối đa tài nguyên.

## 3. Một số khái niệm khi sử dụng docker
### 3.1. Dockerfile
- Docker image có thể được tạo ra tự động bằng cách đọc các chỉ dẫn trong Dockerfile.
- Dockerfile mô tả ứng dụng và nó nói với docker cách để xây dựng nó thành 1 image.
- Dockerfile bắt đầu bằng chữ D và được đặt tên là Dockerfile, ngoài tên này ra các tên khác đều không hợp lệ.

### 3.2. Docker image
- Image trong docker còn được gọi là mirror, nó là 1 đơn vị đóng gói chứa mọi thứ cần thiết để 1 ứng dụng chạy.
- Ta có thể có được image docker bằng cách pulling từ image registry. Thao tác pulling sẽ tải image xuống máy chủ docker, nơi docker có thể sử dụng nó để chạy 1 hoặc nhiều container.
- Image được tạo thành từ nhiều layer xếp chồng lên nhau, bên trong image là 1 hệ điều hành bị cắt giảm và tất cả các phụ thuộc cần thiết để chạy 1 ứng dụng.

### 3.3. Registry
- Docker Registry là nơi lưu trữ các image với hai chế độ là private và public.
- Là nơi cho phép chia sẻ các image template để sử dụng trong quá trình làm việc với Docker.
- Cơ quan registry phổ biến nhất là Docker Hub, nhưng vẫn tồn tại các cơ quan khác.

### 3.4. Docker container
- Một image có thể đước sử dụng để tạo 1 hoặc nhiều container. Ta có thể create, start, stop, move hoặc delete dựa trên Docker API hoặc Docker CLI.

- Trong mô hình container, hệ điều hành yêu cầu tất cả các tài nguyên phần cứng. Trên hệ điều hành, ta cài đặt container engine là docker. Sau đó, công cụ container sẽ lấy các tài nguyên hệ điều hành và ghép chúng lại thành các cấu trúc riêng biệt được gọi là container.
- Mỗi container bao gồm mọi thứ cần thiết để chạy được nó: code, runtime, system tools, system libraries, setting. Mỗi container như 1 hệ điều hành thực sự, bên trong mỗi container sẽ chạy 1 ứng dụng.

- Container và VM có sự cách ly và phân bổ tài nguyên tương tự nhưng có chức năng khác nhau vì container ảo hóa hệ điều hành thay vì phần cứng. Các container có tính portable và hiệu quả hơn.

- Container nhằm làm cho các ứng dụng trở nên dễ dàng xây dựng, di chuyển và chạy. Quá trình đưa 1 ứng dụng chạy trong container có để được hiểu như sau:
1. Đầu tiên ta bắt đầu với code app và các phụ thuộc của nó
2. Tạo Dockerfile mô tả ứng dụng, các phụ thuộc và cách chạy ứng dụng đó
3. Bulid Dockerfile thành image
4. Push image mới build vào registry(option)
5. Chạy container từ image

## 4. Kiến trúc, các thành phần trong Docker
### 4.1. Các thành phần
Docker Engine là một ứng dụng client-server với các thành phần chính sau:
- Server hay còn được gọi là docker daemon chịu trách nhiệm tạo, quản lý các Docker object như: image, containers, networks, volume.
- REST API được docker daemon sử dụng để cung cấp các api cho client sử dụng để thao tác với docker
- Client là thành phần đầu cuối cung cấp một tập hợp các câu lệnh sử dụng API để người dùng thao tác với Docker. VD: docker image, docker ps, docker network, ..

### 4.2. Kiến trúc Docker
Client sẽ sử dụng Docker REST API để tương tác với Docker daemon.

- Docker client sử dụng kiến trúc client-server. Docker client sẽ giao tiếp với Docker daemon các công việc building, running và distributing các Docker container.
- Docker daemon nghe các yêu cầu từ REST API và quản lý các đối tượng Docker như: Containers, Image, Networks và Volume. Một daemon cũng có thể liên lạc với các daemons khác để quản lý Docker services.
- Docker registries để cho các docker image đăng ký lưu trữ qua Docker Hub để bạn hoặc người khác có thể kéo về 1 cách dễ dàng.

## 5. Cài đặt
Để cài đặt docker hết sức đơn giản, ở đây mình sẽ hướng dẫn cài đặt Docker trên Ubuntu 18.04, để cài đặt Docker trên các OS khác, các bạn hãy tham khảo tại: https://docs.docker.com/engine/install/
- Update hệ thống:
```bash
apt-get update -y
```
- Tải về docker engine:
```bash
apt-get install docker.io -y 
```
- Khởi động docker:
```bash
systemctl start docker
systemctl enable docker
```
- Kiểm tra phiên bản docker mà ta vừa tải về:
```bash
root@docker:~# docker --version
Docker version 19.03.6, build 369ce74a3c
```

## 6. Tổng kết
Ở bài này mình đã đưa ra một số thông tin giới thiêụ về docker và các kiến trúc thành phần của docker để tiếp cận ban đầu với docker cũng như cách cài đặt docker engine lên máy chủ của bạn. Sau khi cài đặt, bạn có thể tìm hiểu chi tiết hơn về từng thành phần trong kiến trúc của docker hoặc theo dõi các bài tiếp theo của seri Docker này tại đây nhé !