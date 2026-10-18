# Docker – Phần 2 – Tìm hiểu về Docker images

Ở bài trước, về cơ bản ta đã nắm được docker là gì và khái niệm các thành phần để sử dụng docker. Để tiếp tục với series docker, hôm nay ta sẽ tìm hiểu về docker image để biết cách quản lý các images nhé !

## 1. Tổng quan về images docker

Image docker là 1 đơn vị đóng gói chứa mọi thứ cần thiết để 1 ứng dụng chạy. Nó bao gồm application code, application dependencies, OS constructs. Nếu bạn có 1 image docker của 1 ứng dụng, để chạy ứng dụng đó ta cần 1 máy docker đang chạy.
Để có image, ta có thể pull image từ registry hoặc build image từ Dockerfile.
Khi 1 container được tạo, nó sẽ kéo (pull) các image từ Docker Hub (registry mặc định) về máy chạy docker sau đó tạo container từ image đó.
Images như 1 container đã bị stopped, vậy nên image còn được coi là build-time còn container thì được coi là run-time.

### 1.1. Image và containers

Khi 1 container tạo và chạy từ 1 image, 2 cấu trúc trở nên phụ thuộc vào nhau và ta không thể xóa image cho đến khi container cuối cùng sử dụng nó bị xóa. Nếu cố gắng xóa 1 image mà không dừng hoặc xóa container sẽ dẫn đến lỗi.

### 1.2. Dung lượng image luôn nhỏ

Mục đích của container là chạy 1 ứng dụng hoặc 1 dịch vụ. Điều này có nghĩa là nó chỉ cần code của ứng dụng và các phụ thuộc mà ứng dụng đó cần, nó không cần bất cứ thứ gì khác. Vậy nên image luôn có dung lượng thấp vì nó loại bỏ tất cả các phần không thiết yếu.
Image không chứa kernel – Tất cả các container chạy trên máy chủ Docker đều được chia sẻ quyền truy cập vào kernel của máy chủ đó.
Một ví dụ điển hình về mức độ nhỏ của images là image chính thức của Alpine khoảng 5,5MB, có những image có thể nhỏ hơn. Một ví dụ điển hình hơn là image docker của ubuntu 18.04 có dung lượng khoảng 60MB. Các image rõ ràng đã bị loại bỏ hầu hết các phần không cần thiết.
Một số image của windows có xu hướng lớn hơn rất nhiều so với image Linux do cách thức hoạt động của nó. Dung lượng của image windows có thể lên đến vài gigabyte và khi pull sẽ mất nhiều thời gian hơn.

### 1.3. Pulling images

Nơi lưu trữ image tại local thường được đặt tại /var/lib/docker/image đối với Linux và C:\ProgramData\docker\windowsfilter đối với windows. Có thể sử dụng lệnh sau để kiểm tra xem có bất cứ image nào được lưu trữ cục bộ hay không.

```
root@docker:~# docker images
REPOSITORY                  TAG       IMAGE ID       CREATED        SIZE
```

Quá trình để nhận được image về máy chủ docker được gọi là pulling. Vì vậy nếu muốn có 1 image mới về máy chủ docker, ta có thể sử dụng docker pull và kiểm tra lại với docker images
Ví dụ:

```
root@docker:~# docker pull alpine
Using default tag: latest
latest: Pulling from library/alpine
540db60ca938: Already exists
Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
root@docker:~# docker images
REPOSITORY                  TAG       IMAGE ID       CREATED        SIZE
alpine                      latest    6dbb9cc54074   2 weeks ago    5.61MB
```

Ta thấy rằng các image vừa được pull đã có trên máy chủ docker.

### 1.4. Image registries

Như đã đề cập ở các mục trước, image được lưu trữ tại nơi lưu trữ tập trung được gọi là image registries. Điều này giúp dễ dàng chia sẻ và truy cập. Resgistry phổ biến và được sử dụng mặc định là Docker Hub.
Registry chứa 1 hoặc nhiều image repositories, trong image repositories chứa 1 hoặc nhiều image. Như hình sau đây cho thấy cách registry lưu trữ các image.

#### 1.4.1. Repo chính thức và không chính thức

Docker Hub có 2 khai niệm là lưu trữ chính thức (official repositories) và lưu trữ không chính thức (unoffical repositories).
Các kho lưu trữ chính thức là nơi lưu trữ các image được kiểm duyệt và quản lý bởi Docker, Inc. Với các kho lưu trữ này sẽ được docker đánh nhãn là Docker Official Images.
Các kho lưu trữ không chính thức không bị kiểm duyệt có thể không an toàn vì chúng không được kiểm định. Tuy nhiên không phải mọi kho lưu trữ không được kiểm duyệt đều xấu, chỉ là bạn nên cẩn thận trước khi sử dụng những thứ từ kho lưu trữ không chính thức. Tốt nhất là nên tin tưởng vào những image có lượt tải xuống cao hoặc image từ những repo nổi tiếng.
Ví dụ về 1 số repo chính thức:
nginx: https://hub.docker.com/_/nginx/
busybox: https://hub.docker.com/_/busybox/
redis: https://hub.docker.com/_/redis/
mongo: https://hub.docker.com/_/mongo/
Ví dụ về 1 số repo không chính thức:
nigelpoulton/tu-demo — https://hub.docker.com/r/nigelpoulton/tu-demo/
nigelpoulton/pluralsight-docker-ci — https://hub.docker.com/r/nigelpoulton/pluralsight-docker-ci/

### 1.5. Tên và tag trong images

Để pull 1 image từ repo chính thức, ta cần chỉ ra tên của repo và thẻ của nó (tag) cách nhau bởi dấu : , nếu không chỉ ra tag, nó sẽ hiểu mặc định tag là latest.

```
docker image pull <repository>:<tag>
```

Ví dụ để thêm 1 image từ kho lưu trữ chính thức:

```
root@docker:~# docker image pull redis
Using default tag: latest
latest: Pulling from library/redis
f7ec5a41d630: Already exists
a36224ca8bbd: Pull complete
7630ad34dcb2: Pull complete
c6d2a5632e6c: Pull complete
f1957981f3c1: Pull complete
42642d666cff: Pull complete
Digest: sha256:e10f55f92478715698a2cef97c2bbdc48df2a05081edd884938903aa60df6396
Status: Downloaded newer image for redis:latest
docker.io/library/redis:latest
```

hoặc

```
root@docker:~# docker pull httpd:2.4
2.4: Pulling from library/httpd
f7ec5a41d630: Already exists
d1589b6d8645: Pull complete
83d3755a8d28: Pull complete
f8459b08e404: Pull complete
30fabbf5a067: Pull complete
Digest: sha256:a6e472ad921c93d9fc2cbe2ff07560b9a526c145c4e10faff3aeb28c48cce585
Status: Downloaded newer image for httpd:2.4
docker.io/library/httpd:2.4
```

Để thêm 1 image từ repo không chính thức cũng giống như repo chính thức nhưng ta thêm tên của người dùng Docker Hub hoặc tên của tổ chức vào trước.

```
docker image pull nigelpoulton/tu-demo:v2
```

### 1.6. Image sử dụng multiple tags

Một image có thể có nhiều tags, nếu muốn pull tất cả các image trong 1 kho lưu trữ, hãy sử dụng thêm tùy chọn -a.

```
docker image pull -a mongo
```

```
root@docker:~# docker image ls | grep "mongo"
mongo                  4.2.6               3f3daf863757        10 months ago       388MB
mongo                  3-stretch           27d820d7098b        23 months ago       373MB
mongo                  3-jessie            b9406b8a16ec        2 years ago         368MB
mongo                  2                   1999482cb0a5        4 years ago         391MB
mongo                  2.6                 1999482cb0a5        4 years ago         391MB
mongo                  2.6.12              1999482cb0a5        4 years ago         391MB
mongo                  2.4                 2affaf1f84e0        4 years ago         342MB
mongo                  2.4.14              2affaf1f84e0        4 years ago         342MB
mongo                  2.2                 8558fe135d54        4 years ago         237MB
mongo                  2.2.7               8558fe135d54        4 years ago         237MB
mongo                  2.6.11              f36fb0070896        5 years ago         391MB
mongo                  2.6.10              54fb6f9984dd        5 years ago         393MB
mongo                  2.6.9               0eb5bcb2f408        5 years ago         392MB
mongo                  2.4.13              1bc8a1a8ad40        5 years ago         344MB
mongo                  2.6.8               f287f6ca320f        5 years ago         393MB
mongo                  2.6.7               0fa5e3f671a7        6 years ago         392MB
mongo                  2.4.12              ae5e97f89258        6 years ago         345MB
mongo                  2.8                 4af37f2deb97        6 years ago         225MB
mongo                  2.8.0               4af37f2deb97        6 years ago         225MB
mongo                  2.8.0-rc5           4af37f2deb97        6 years ago         225MB
mongo                  2.8.0-rc4           c732b27ee3d6        6 years ago         224MB
mongo                  2.6.6               7632cab977f9        6 years ago         392MB
mongo                  2.8.0-rc3           84a5935d697f        6 years ago         224MB
mongo                  2.8.0-rc0           afb23b2838b9        6 years ago         224MB
mongo                  2.6.5               6e2f39336075        6 years ago         392MB
mongo                  2.7                 1bc6f44f84be        6 years ago         217MB
mongo                  2.7.8               1bc6f44f84be        6 years ago         217MB
mongo                  2.7.7               e29d06d58a5e        6 years ago         237MB
mongo                  2.4.11              be2b25bde5f5        6 years ago         345MB
mongo                  2.6.4               d90d629f1e23        6 years ago         391MB
mongo                  2.7.6               18400f87db91        6 years ago         381MB
mongo                  2.4.10              9ee0bcea2cbf        6 years ago         345MB
mongo                  2.7.5               5f79484e67e9        6 years ago         379MB
mongo                  2.6.1               f4eb787e7fd8        6 years ago         748MB
```

### 1.7. Tìm kiếm image từ Docker Hub

Lệnh docker search cho phép ta tìm kiếm trên Docker Hub từ CLI. Ví dụ để tìm các image alpine trên Docker Hub

```
root@docker:~# docker search alpine
NAME                                   DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
alpine                                 A minimal Docker image based on Alpine Linux…   7380      [OK]
mhart/alpine-node                      Minimal Node.js built on Alpine Linux           483
anapsix/alpine-java                    Oracle Java 8 (and 7) with GLIBC 2.28 over A…   469                  [OK]
frolvlad/alpine-glibc                  Alpine Docker image with glibc (~12MB)          259                  [OK]
alpine/git                             A  simple git container running in alpine li…   175                  [OK]
yobasystems/alpine-mariadb             MariaDB running on Alpine Linux [docker] [am…   86                   [OK]
alpine/socat                           Run socat command in alpine container           68                   [OK]
kiasaki/alpine-postgres                PostgreSQL docker image based on Alpine Linux   44                   [OK]
davidcaste/alpine-tomcat               Apache Tomcat 7/8 using Oracle Java 7/8 with…   44                   [OK]
jfloff/alpine-python                   A small, more complete, Python Docker image …   41                   [OK]
byrnedo/alpine-curl                    Alpine linux with curl installed and set as …   34                   [OK]
hermsi/alpine-sshd                     Dockerize your OpenSSH-server with rsync and…   33                   [OK]
zenika/alpine-chrome                   Chrome running in headless mode in a tiny Al…   33                   [OK]
hermsi/alpine-fpm-php                  FPM-PHP 7.0 to 8.0, shipped along with tons …   25                   [OK]
etopian/alpine-php-wordpress           Alpine WordPress Nginx PHP-FPM WP-CLI           24                   [OK]
bashell/alpine-bash                    Alpine Linux with /bin/bash as a default she…   18                   [OK]
davidcaste/alpine-java-unlimited-jce   Oracle Java 8 (and 7) with GLIBC 2.21 over A…   13                   [OK]
roribio16/alpine-sqs                   Dockerized ElasticMQ server + web UI over Al…   12                   [OK]
spotify/alpine                         Alpine image with `bash` and `curl`.            11                   [OK]
cfmanteiga/alpine-bash-curl-jq         Docker Alpine image with Bash, curl and jq p…   6                    [OK]
hermsi/alpine-varnish                  Dockerize Varnish upon a lightweight alpine-…   3                    [OK]
ellerbrock/alpine-mysql-client         MySQL Client based on Alpine Linux              1                    [OK]
dwdraju/alpine-curl-jq                 Alpine Docker Image with curl, jq, bash         1                    [OK]
goodguykoi/alpine-curl-internal        simple alpine image with curl installed no C…   1                    [OK]
bushrangers/alpine-caddy               Alpine Linux Docker Container running Caddys…   1                    [OK]
```

* Cột NAME: cho biết tên của image
* Cột DESCRIPTION: mô tả ngắn gọn images
* Cột OFFICIAL: cho biết đó là image chính thức hay không chính thức

Nếu chỉ muốn tìm những image chính thức hãy sử dụng lệnh sau để lọc:

```
docker search alpine --filter "is-official=true"
```

### 1.8. Images và layers

#### 1.8.1. Layer trong images

Images Docker là 1 loạt các layer read-only được kết nối với nhau. Mỗi layer bao gồm 1 hoặc nhiều file.

Trên thực tế, khi ta pull 1 image ta sẽ thấy các layer của image đó:

```
root@docker:~# docker image pull ubuntu:latest
latest: Pulling from library/ubuntu
952132ac251a: Pull complete
82659f8f1b76: Pull complete
c19118ca682d: Pull complete
8296858250fe: Pull complete
24e0251a0e2c: Pull complete
Digest: sha256:f4691c96e6bbaa99d...28ae95a60369c506dd6e6f6ab
Status: Downloaded newer image for ubuntu:latest
docker.io/ubuntu:latest
```

Mỗi dòng sẽ kết thúc bằng Pull complete đại diện cho 1 layer đã được pull.

Một các khác để xem các layer của image là sử dụng docker image inspect:

```
root@docker:~# docker inspect ubuntu:latest
[
    {
        "Id": "sha256:bd3d4369ae.......fa2645f5699037d7d8c6b415a10",
        "RepoTags": [
            "ubuntu:latest"
            
        <Snip>

        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:c8a75145fc...894129005e461a43875a094b93412",
                "sha256:c6f2b330b6...7214ed6aac305dd03f70b95cdc610",
                "sha256:055757a193...3a9565d78962c7f368d5ac5984998",
                "sha256:4837348061...12695f548406ea77feb5074e195e3",
                "sha256:0cad5e07ba...4bae4cfc66b376265e16c32a0aae9"
            ]
        }
    }
]
```

Docker sử dụng storage driver để chịu trách nhiệm cho việc xếp chồng các layer và trình bày chúng như 1 thể thống nhất. Ví dụ về storage driver bao gồm: AUFS, overlay2, devicemapper, btrfs và zfs.

#### 1.8.2. Chia sẻ layer giữa các image

Các image có thể chia sẻ các layer với nhau, điều này dẫn đến hiệu quả về không gian và hiệu suất. Khi pull image, các trạng thái layer được thông báo là Already exists tức là layer đó đã tồn tại và image sẽ sử dụng layer đó mà không cần pull layer mới.

### 1.9. Multi-architecture images

Image Docker có thể hỗ trợ nhiều kiến trúc, có nghĩa là 1 image có thể chứa nhiều biến thể cho các kiến trúc khác nhau và đôi khi cho các hệ điều hành khác nhau.
Khi chạy 1 image hỗ trợ multi-architecture, docker sẽ tự động chọn 1 biến thể image phù hợp với hệ điều hành và kiến trúc của máy. Hầu hết các image đều cung cấp nhiều loại kiến trúc khác nhau.
Có nghĩa là 1 image chẳng hạn như golang có thể có image cho linux trên x64, hoặc các phiên bản khác nhau trên ARM và hơn thế nữa. Có nghĩa là khi bạn đứng trên bất kỳ nền tảng hoặc kiến trúc nào và thực hiện pull image, docker sẽ pull image chính xác phù hợp bới nền tảng hoặc kiến trúc đó.
Để làm được điều này, Registry API hỗ trợ 2 cấu trúc:

* manifest lists
* manifests

Hình trên cho thấy khi ta pull 1 image, có sẽ dựa vào kiến trúc cpu của máy chủ docker để lựa chọn phiên bản phù hợp. Ta không cần phải chỉ ra rằng ta cần phiên hản linux x64 hay windows x64, chỉ cần chạy các lệnh như bình thường và docker tự xử lý để có được 1 image phù hợp với nền tảng kiến trúc mà máy chủ docker đang chạy.

### 1.10. Xóa images

Khi không còn cần đến images trên docker của mình nữa, ta có thể sử dụng docker image rm để xóa image. Khi xóa image sẽ xóa tất cả các layer của nó. Tuy nhiên, nếu 1 layer của image chia sẻ cho nhiều image khác thì layer đó sẽ không bị xóa cho đến khi tất cả các image tham chiếu đến nó đều bị xóa hết.

```
root@docker:~# docker image rm httpd:2.4
Untagged: httpd:2.4
Untagged: httpd@sha256:a6e472ad921c93d9fc2cbe2ff07560b9a526c145c4e10faff3aeb28c48cce585
Deleted: sha256:0b932df43057fbcc4276ae50fc0efe2f446d1955066d5774e764ef1f77638511
Deleted: sha256:2a455380a6b6556b6c74970d3ed6ed7cdf129faf017b0df678cf90c661df7971
Deleted: sha256:cb1255155eeaa614a1c12714454886e6581b78bc5942d1edf1910f67b9b81ea2
Deleted: sha256:6e35a2713ae7c4b470f2e3e245c3f0f7808911d4086ecd32e1dc9b53c184a94a
Deleted: sha256:902d020d1a22522b22d02e2787652b9f4b306d619d742216eeee0af2d800cde2
```

Để xóa tất cả các image, hãy sử dụng lệnh sau:

```
docker image rm $(docker image ls -q) -f
```

## 2. Tổng hợp các lệnh với image

* docker image pull là lệnh sử dụng để download image. Các image sẽ được pull từ kho lưu trữ của registry từ xa. Theo mặc định, images sẽ được pull từ Docker Hub.
* docker image ls là lệnh sử dụng để liệt kê các image trong image cache của máy chủ Docker cục bộ.
* docker image inspect cung cấp cho ta chi tiết về images như layer, data và metadata
* docker image rm là lệnh để xóa images. Bạn không thể xóa xác image khi nó đang được sử dụng bởi container.

## 3. Tổng kết

Ở phần này ta đã tìm hiểu cơ bản về các image Docker. Ở một khía cạnh nào đó, images giống như các templates máy ảo được sử dụng để khởi động các container. Phía trong nó được tạo thành từ 1 hoặc nhiều các layer read-only xếp chồng lên nhau tạo nên tổng thể của 1 image. Ở phần tiếp theo mình sẽ cùng tìm hiểu về cách sử dụng Docker file để xây dựng lên 1 image, hãy tiếp tục theo dõi tại đây nhé !