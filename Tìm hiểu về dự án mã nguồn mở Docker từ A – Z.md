# Docker là gì? Tìm hiểu về dự án mã nguồn mở Docker từ A – Z

Docker được biết đến là nền tảng cung cấp cho người dùng các building, deploying, running ứng dụng một cách dễ dàng nhất có thể. Bởi vì tính ứng dụng mà ngay nay Docker đã trở thành một nền tảng phổ biến. Bài viết này chúng ta sẽ tìm hiểu về khái niệm docker là gì, tất tần tật về các dự án nguồn mở của Docker.

## Danh Mục
- Docker là gì?
- Docker Container là gì?
- Docker hoạt động như thế nào?
- Quy trình thực thi của hệ thống khi sử dụng Docker
  - Build
  - Push
  - Pull, Run
- Tại sao nên sử dụng Docker?
- Khi nào nên sử dụng Docker?
- Một số lệnh cơ bản trong docker
- Một số khái niệm liên quan đến Docker

## Docker là gì?
Vấn đề đầu tiên mà bạn cần tìm hiểu docker là gì? Docker chính là một nền tảng được sử dụng để cung cấp cho bạn cách building, deploying và cả running ứng dụng một cách dễ dàng hơn. Docker sẽ hoạt động thông qua cách sử dụng những containers ở trên nền tảng ảo hóa. Lúc đầu, chúng sẽ được viết bằng Python và hiện tại thì đã chuyển sang Golang.
- Docker là gì?

## Docker Container là gì?
Khi tìm hiểu Docker Container, bạn cần biết rằng, những containers sẽ cho phép các lập trình viên đóng gói một ứng dụng. Trong đó bao gồm những phần cần thiết, ví dụ như thư viện cùng với các phụ thuộc khác. Chúng cũng gói tất cả ra ở dưới dạng là một package. Thông qua đó, nhờ vào containers thì ứng dụng sẽ chạy ở trên tất cả máy tính Linux khác. Dù cho mọi cài đặt tùy chỉnh khác nhau mà máy có thể khác đối với những chiếc máy được sử dụng để viết code. 
- Docker container là gì?

Bằng một cách nào đó, Docker khá là giống với virtual machine. Vậy tại sao Docker lại phát triển hơn và phổ biến hơn. Nguyên nhân chính là vì những ưu điểm sau đây:
- Dễ ứng dụng: Bất cứ ai cũng có thể sử dụng từ lập trình viên cho đến sysadmin,… chúng tận dụng tất cả lợi thế của containers để build và test một cách nhanh chóng. Chúng có thể đóng gói ứng dụng ở trên laptop và chạy ở trên public cloud và cả private cloud,… Một câu thần chú ở đây là “Build once, run anywhere”
- Tốc độ: Docker Containers tương đối nhẹ và có tốc độ rất nhanh. Bạn hoàn toàn có thể tạo và khởi chạy chỉ trong vài giây ngắn ngủi. 
- Môi trường chạy và khả năng mở rộng: Bạn có thể chia nhỏ những chức năng của ứng dụng thành các container riêng lẻ. Ví dụng Database chạy trên một container và Redis cache có thể chạy trên một container khác trong khi ứng dụng Node.js lại chạy trên một cái khác nữa. Với Docker, rất dễ để liên kết các container với nhau để tạo thành một ứng dụng, làm cho nó dễ dàng scale, update các thành phần độc lập với nhau.

## Docker hoạt động như thế nào?
Docker hoạt động bằng cách chạy mã bằng cung cấp phương thức tiêu chuẩn. Nó giống như cách máy ảo – ảo hóa phần cứng của máy chủ nhằm loại bỏ nhu cầu trực tiếp quản lý, lúc này các container sẽ ảo hóa hệ điều hành của máy chủ. Khi được cài đặt trên từng máy chủ, docker cung cấp các lệnh cơ bản để bạn có thể build, khởi tạo hay dừng container.
- Docker hoạt động như thế nào?

Cơ chế hoạt động của Docker khá phức tạp. Hoạt động của Docker sẽ thông qua một Docker Engine có sự kết hợp của hai yếu tố server và client. Server và Client giao tiếp với nhau thông qua REST API.

Bên cạnh đó, các dịch vụ như Amazon ECS,  AWS Fargate,  Amazon EKS và AWS Batch sẽ giúp bạn dễ dàng chạy các Container Docker ở quy mô lớn,

Đặc biệt, nếu bạn đang sử dụng hệ điều hành của Windows hoặc Mac thế hệ cũ, bạn hoàn toàn có thể tận dụng Docker Toolbox bởi nó cho phép bạn điều khiển Docker Engine với Docker Compose và Kitematic.

## Quy trình thực thi của hệ thống khi sử dụng Docker
Thông thường, để thực thi hệ thống Docker, cần trải qua ba bước: Build, Push và Pull, Run. Cụ thể các bước nào sẽ có quy trình thực thi như thế nào?

### Build
Đây là bước đầu tiên để tạo một dockerfile. Bên trong dockerfile chính là code của chúng ta. Cụ thể dockerfile sẽ được xây dựng tại một máy tính đã cài đặt sẵn Docker Engine. Sau khi build xong, chúng ta sẽ có được Container và trong này sẽ có chứa ứng dụng kèm với toàn bộ thư viện.
- Quy trình thực thi của hệ thống khi sử dụng docker

### Push
Sau khi có được container, bước push là bước đẩy contain lên cloud và lưu trữ tại đó.

### Pull, Run
Trong trường hợp có một máy tính khác muốn sử dụng Container, thì máy bắt buộc phải thực hiện Pull Container về máy và máy đã cài sẵn Docker Engine. Sau đó, để sử dụng Container phải thực hiện Run Container này.

## Tại sao nên sử dụng Docker?
Chúng ta đã tìm hiểu về khái niệm của Docker, cách thức hoạt động của Docker. Vậy chúng ta có biết tạo sao nên sử dụng Docker không và docker dùng để làm gì?

Đầu tiên, để có thể setup và deploy application lên một hoặc nhiều server khá khó khăn và vất vả từ khâu cài đặt các công cụ, môi trường cần cho application cho đến việc chạy ứng dụng. Bên cạnh đó các môi trường server thường không đồng nhất với nhau, do đó việc setup và deploy application lên server rất khó khăn. Để giải quyết vấn đề này, Docker đã ra đời.
- Tại sao nên dùng Docker?

Ngày nay, Docker được sử dụng khá phổ biến và rộng rãi, trong đó Docker và Container hoàn toàn có thể sử dụng cho nhau. Công nghệ liên quan Container ra đời rất lâu trước khi Docker được phát hành, cho phép ảo hóa một phiên Linux.

Sau đó các bản đầu của Docker ra đời, tạo đòn bẩy lớn cho các sản phẩm mà chỉ sử dụng riêng cho LXC. Bên cạnh đó, Docker còn có những đặc điểm nổi bật sau:
- Vận chuyển phần mềm nhiều và nhanh chóng hơn
Trên thực tế, vận chuyển phần mềm đối với những người sử dụng docker nhanh hơn trung bình 7 lần so với những người không sử dụng Docker. Nhờ đó mà Docker mang đến cho mình một điểm nổi bật về khả năng vận chuyển dịch vụ được tách riêng với tần suất mong muốn.
- Tiêu chuẩn hóa quá trình vận hành
Tiêu chuẩn hóa quá trình vận hành ở đây chính là các ứng dụng sẽ được đóng gói vào các container nhỏ, việc này sẽ giúp việc triển khai, xác định vấn dề hay đảo ngược để khắc phục vấn đề trở nên dễ dàng hơn bao giờ hết.g.
- Di chuyển trơn tru hiệu quả
Điểm nổi bật của Docker chính là khả năng di chuyển ứng dụng trên nền tảng Docker trơn tru, đạt hiệu quả cao từ vị trí các máy phát triển cục bộ đến các đơn vị triển khai sản xuất trên AWS.
- Tiết kiệm chi phí tối đa
Điểm nổi bật của Container Docker chính là có thể giúp cho việc chạy nhiều mã trên từng máy chủ trở được thực hiện dễ dàng hơn. Bên cạnh đó, cải thiện được khả năng tận dụng cũng như tiết kiệm được nhiều chi phí cho bạn.

## Khi nào nên sử dụng Docker?
Docker mang đến cho người dùng nhiều lợi ích tuyệt vời. Vậy chúng ta nên sử dụng Docker khi nào và lợi ích của Docker là gì?

Chúng ta hoàn có thể sử dụng Container Docker để làm khối dựng lõi nhằm tạo ra ứng dụng và nền tảng hiện đại. Bên cạnh đó, nó còn phân phối được việc dựng và chạy các kiến trúc vi dịch vụ, quy trình tổng hợp và phân phối liên tục khi triển khai mã được tiêu chuẩn hóa. 

Hệ thống xử lý dữ liệu được xây dựng có quy mô cực kỳ linh hoạt và nhờ đó mà tạo ra các nền tảng có khả năng quản lý đầy đủ, dễ dàng hơn cho các nhà phát triển. Hơn nữa, sự hợp tác giữa AWS và Docker mang đến những điểm cộng về quá trình triển khai các phần lạ một cách dễ dàng của Docker Compose cho Amazon ECS và AWS Fargate.
- Khi nào nên sử dụng Docker?

Bên cạnh đó, Docker còn được sử dụng trong các trường hợp như: Microservices triển khai kiến trúc hay khi xây dựng một ứng dụng và các tỷ lệ cần phải có sự linh hoạt. Hoặc khi bạn không muốn tốn quá nhiều thời gian cho việc onfig máy local và server trong cùng một môi trường để chạy ứng dụng, sử dụng Docker bạn chỉ cần build một lần nhưng có thể chạy được nhiều nơi.

Docker còn được sử dụng khi sản phẩm của công ty bạn đang cần một cách tiếp cận mới về các yếu tố xây dựng, đẩy lên server, thực thi ứng dụng đòi hỏi nhanh chóng, dễ dàng.

## Một số lệnh cơ bản trong docker
Sau đây là một số lệnh cơ bản của Docker mà người dùng thường gặp và cần phải sử dụng:
- Lệnh List image/container: `$ docker image/container ls`
- Lệnh Delete image/container: `$ docker image/container rm <tên image/container >`
- Lệnh Delete all image hiện có: `$ docker image rm $(docker images –a –q)`
- List all container hiện có: `$ docker ps –a`
- Lệnh Stop a container cụ thể: `$ docker stop <tên container>`
- Lệnh Run container từ image và thay đổi tên container: `$ docker run –name <tên container> <tên image>`
- Lệnh Stop all container: `$ docker stop $(docker ps –a –q)`
- Lệnh Delete all container hiện có: `$ docker rm $(docker ps –a –q)`
- Lệnh Show log a container: `$ docker logs <tên container>`
- Lệnh Build một image từ container: `$ docker build -t <tên container>`
- Lệnh Tạo một container chạy ngầm: `$ docker run -d <tên image>`
- Lệnh Tải một image trên docker hub: `$ docker pull <tên image>`
- Lệnh Start một container: `$ docker start <tên container>`
- Một số lệnh cơ bản trong Docker

## Một số khái niệm liên quan đến Docker
Chúng ta đã tìm hiểu các khái niệm cơ bản về docker là gì? Hoạt động, quy trình thực thi của Docker. Sau đây là một số khái niệm liên quan đến Docker để có thể hiểu rõ hơn về nền tảng này:
- Docker Engine: Đây là thành phần chính của docker, có chức năng như một công cụ dùng để đóng gói ứng dụng.
- Docker Hub: Được biết đến là một kho lưu trữ công khai của Docker image, bên cạnh đó còn có một tên gọi khác là “thư viện và cộng đồng lớn nhất thế giới về image container”. Docker Hub có chứa khoảng hơn 100.000 image container, những image container này được lấy từ các nhà cung cấp phần mềm thương mại, các nhà phát triển cá nhân, các dự án có mã nguồn mở.
Docker hub còn chứa những image được sản xuất bởi Docker Inc và các image được chứng nhận bởi các cơ quan đăng ký tin cậy. Trên docker hub, bạn có thể dễ dàng tìm kiếm image bạn cần và tải lên tất cả image mà bạn muốn, chỉ cần pull về và sử dụng với các config mà bạn muốn.
- Một vài khái niệm liên quan đến Docker
- Docker Images: Đây được biết đến là một khuôn mẫu dùng để tạo ra một Container, có chứa mã nguồn ứng dụng thư thì, cũng như có chứa tất cả công cũ, thư viện. Thường image sẽ dựa trên một image có sẵn nào đó và có thêm sự tùy chỉnh. Chẳng hạn như khi bạn build một image dựa vào image Centos có sẵn mẫu dùng để chạy Nginx với những tùy chỉnh, thì cấu hình web của bạn có thể hoàn toàn chạy được. Bạn hoàn toàn có thể tự build một image cho mình hoặc có thể sử dụng image trên Docker hub để dụng. Trường hợp nếu tự build image, bạn sẽ nhận được sự chỉ dẫn từ Dockerfile.
- Docker Container: Chính là một phiên bản live hay running instance của một Docker image. Cụ thể, ta thấy docker image là file dùng để đọc trong khi đó docker container là phiên bản live, executable mà tại đây người dùng hoàn toàn có thể tương tác với chung. Bên cạnh đó, quản trị viên hoàn toàn có thể điều chỉnh cài đặt để phù hợp với các yêu cầu, quy định của họ. Tại docker container, bạn hoàn toàn có thể thực hiện các bước như create, start, stop, move or delete container dựa trên Docker API hoặc Docker CLI.
- Docker Client: Đây là một công cụ hỗ trợ người dùng giao tiếp với Docker host. Docker host chính là thành phần mà thông qua command line có thể giúp bạn kết nối, giao tiếp với Docker host. Thông tường, Docker client sẽ thực hiện bằng cách thông qua REST API gửi lệnh tới Docker Daemon.
- Docker Daemon: Đây là nơi lắng nghe các yêu cầu đến từ Docker client với mục đích quản lý các đối tượng thông qua REST API như image, container, Network hay Volumes. Bên cạnh đó, các Docker Daemon cũng giao tiếp với nhau nhằm quản lý các Docker Services.
- Dockerfile: Chính là một tệp tin mà trong đó có chứa các chỉ dẫn, hướng dẫn để có thể build một image. Một container docker thường bắt đầu bằng một file văn bản với hình thức đơn giản, trong đó có chứa các hướng dẫn về cách build một image container docker. Bên cạnh đó, Dockerfile còn tự động hóa được tiến trình tạo image docker. Dockerfile còn biết đến là danh sách các lệnh được Docker Engine dùng để chạy và tập hợp các image.
- Docker Volumes: Chính là phần dữ liệu được tạo ra trong quá trình các container được khởi tạo.
- Docker machine: Là hệ thống tạo ra các docker engine trên máy chủ.
- Docker Compose: Thực hiện chạy ứng dụng thông qua các định nghĩa cấu hình các Docker Container, thực hiện thông qua file cấu hình.

Bài viết trên, chúng ta đã cùng  tìm hiểu về docker các khái niệm liên quan đến docker như docker là gì, docker container là gì, cách thức hoạt động, thực thi hệ thống của docker, những ưu điểm nổi trội mà Docker mang lại trong build, deploy hay running ứng dụng. Hy vọng những thông tin vừa rồi sẽ giúp bạn hiểu hơn về Docker cũng như sử dụng docker hiệu quả trong công việc và cuộc sống.