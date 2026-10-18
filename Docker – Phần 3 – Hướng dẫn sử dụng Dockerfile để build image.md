Docker – Phần 3 – Hướng dẫn sử dụng Dockerfile để build image

Tiếp tục với seri docker, ở phần trước ta đã tìm hiểu về docker images và cách quản lý image trong docker. Tiếp theo, ta hãy cùng tìm hiểu về Dockerfile để biết cách tạo image từ Dockerfile nhé.
1. Dockerfile là gì?
Dockerfile là điểm bắt đầu để tạp image – nó mô tả ứng dụng và nói với docker cách để xây dựng nó thành 1 image. Nó bao gồm cách lệnh liên tiếp nhau được thực hiện tự động trên 1 image gốc để tạo ra một image mới. Dockerfile bắt đầu bằng chữ D và được đặt tên bắt buộc là Dockerfile. Ngoài tên này, các tên khác đều không hợp lệ
Dưới đây là cấu trúc Dockerfile cơ bản:
FROM alpine
LABEL maintainer="hocchudong@gmail.com"
RUN apk add --update nodejs nodejs-npm
COPY . /src
WORKDIR /src
RUN  npm install
EXPOSE 8080
ENTRYPOINT ["node", "./app.js"]
2. Các chỉ thị trong Dockerfile
2.1. FROM
Tất cả các Dockerfile đều bắt đầu với chỉ thị FROM. Đây là layer cơ sở của image để xây dựng image mới, phần còn lại của ứng dụng sẽ được thêm lên trên cùng dưới dạng các layer bổ sung. Nếu 1 ứng dụng chạy trên Linux thì điều quan trọng là chỉ thị FROM phải được đề cập đến 1 image dựa trên Linux.

2.2. LABEL
Tiếp theo, Dockerfile tạo 1 LABEL dùng để thêm metadata vào image. LABEL là các cặp key–value đơn giản được lưu dưới dạng chuỗi. Có thể khai báo nhiều LABEL trong 1 Dockerfile.
VD:
LABEL maintainer="hocchudong@gmail.com"
LABEL version="3.1"
2.3. RUN
RUN chạy một lệnh nào đó trong quá trình build image và sau khi chạy. Một layer sẽ được thêm lên ngay trên layer cơ sở và các gói sẽ được cài đặt ở layer này.


2.4. COPY
Lệnh copy tạo ra 1 layer khác và sao chép vào ứng dụng các tệp phụ thuộc từ thư mục build image.

2.5. WORKDIR
Tiếp theo Dockerfile sử dụng lệnh WORKDIR để đặt thư mục đang làm việc cho các chỉ thị khác như RUN, CMD, ENTRYPOINT, COPY, ADD, … Chỉ thị này không tạo ra một image layer mới.
VD:
WORKDIR /src
Sau WORKDIR, chỉ thị RUN npm install tạo một layer mới và sử dụng npm để cài đặt các phụ thuộc ứng dụng được liệt kê trong tệp package.json tại thư mục build.

2.6. EXPOSE
Ứng dụng là 1 dịch vụ web chạy trên cổng 8080, do đó, Dockerfile ghi lại điều này bằng chỉ thị EXPOSE. Chủ thị được thêm vào dưới dạng metadata của image chứ không phải layer của image.
VD:
EXPOSE 8080
Lưu ý EXPOSE không có chức năng nat port từ máy host vào container.
2.7. ENTRYPOINT
Cuối cùng, ENTRYPOINT được sử dụng để chạy lệnh trong chỉ thị này khi container được chạy. Tham số được dùng để chuẩn bị các điều kiện setup cần thiết để chạy service trong container như tạo user, tạo thư mục, change owner, …
Cú pháp:
ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
ENTRYPOINT command param1 param2 (shell form)
ENTRYPOINT và CMD có tác dụng tương tự nhay. Nếu một Dockerfile có cả CMD và ENTRYPOINT thì CMD sẽ thành tham số cho ENTRYPOINT.
VD:
ENTRYPOINT ["node", "./app.js"]
2.8. Một số chỉ thị khác
2.8.1. ENV
Chỉ thị ENV được sử dụng để khai báo các biến môi trường. Các biến này được khai báo dạng key – value.
Các biến môi trường có thể được sử dụng trong các chỉ thị sau:
- ADD
- COPY
- ENV
- EXPOSE
- FROM
- LABEL
- STOPSIGNAL
- USER
- VOLUMME
- WORKDIR
Cú pháp:
ENV <key>=<value> ...
2.8.2. CMD
Chỉ thị CMD được dùng để truyền 1 lệnh của linux mỗi khi thực hiện khởi tạo một container từ image (image này được build từ Dockerfile)
Cú pháp:
CMD ["executable","param1","param2"]
CMD ["param1","param2"] 
CMD command param1 param2
VD:

FROM ubuntu
RUN apt-get update
RUN apt-get install wget -y
CMD echo hocchudong
3. Sử dụng Dockerfile để build image
Sau khi hiểu các thành phần chỉ thị trong Dockerfile, ta sẽ tiến hành sử dụng nó để build image.
Mình sẽ build 1 image mới với tên là web và có tag là latest. Bạn có thể down 1 ứng dụng web để thử nghiệm tại đây!
Dấu . để yêu cầu docker sử dụng Dockerfile tại thư mục hiện tại của shell để build image.
cd psweb
docker image build -t web:latest .
Dưới đây là toàn bộ log trong quá trình build
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
npm WARN deprecated debug@4.1.1: Debug versions >=3.2.0 <3.2.7 || >=4 <4.3.1 have a low-severity ReDos regression when used in a Node.js environment. It is recommended you upgrade to 3.2.7 or 4.3.1. (https://github.com/visionmedia/debug/issues/797)
npm WARN deprecated fsevents@2.1.3: "Please update to latest v2.3 or v2.2"
npm WARN deprecated core-js@2.6.12: core-js@<3.3 is no longer maintained and not recommended for usage due to the number of issues. Because of the V8 engine whims, feature detection in old core-js versions could cause a slowdown up to 100x even if nothing is polyfilled. Please, upgrade your dependencies to the actual version of core-js.

> core-js@2.6.12 postinstall /src/node_modules/core-js
> node -e "try{require('./postinstall')}catch(e){}"

Thank you for using core-js ( https://github.com/zloirock/core-js ) for polyfilling JavaScript standard library!

The project needs your help! Please consider supporting of core-js on Open Collective or Patreon:
> https://opencollective.com/core-js
> https://www.patreon.com/zloirock

Also, the author of core-js ( https://github.com/zloirock ) is looking for a good job -)

npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.1.2 (node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.3: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

added 270 packages from 227 contributors and audited 271 packages in 21.061s

44 packages are looking for funding
  run `npm fund` for details

found 1 high severity vulnerability
  run `npm audit fix` to fix them, or `npm audit` for details
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
Liệt kê các image để kiểm tra:
root@dockersrv:~/psweb# docker image ls 

REPOSITORY         TAG          IMAGE ID          CREATED          SIZE
web                latest       b0e41055ddb3      10 minutes ago   93.5MB
Chạy container với image vừa build và nat port 8080 của container sang port 80 của docker host:
docker container run -d --name web1 \
-p 80:8080 \
web:latest
Sau đó sử dụng trình duyệt truy cập vào web với địa chỉ http://<docker_host_ip>

4. Tổng kết
Như vậy, ở phần này ta đã tìm hiểu về cách sử dụng Dockerfile để tự build 1 image và mình cũng giải thích các chỉ thị được sử dụng thường xuyên trong Dockerfile. Ở bài tiếp theo mình sẽ hướng dẫn các bạn cách để triển khai ứng dụng với docker compose, hãy tiếp tục theo dõi tại đây nhé.
Tài liệu tham khảo
[1]. https://www.amazon.com/Docker-Deep-Dive-Nigel-Poulton/dp/1521822808/ref=tmm_pap_swatch_0?_encoding=UTF8&qid=&sr=