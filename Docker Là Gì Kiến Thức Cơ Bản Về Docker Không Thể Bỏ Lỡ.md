# Docker Là Gì? Kiến Thức Cơ Bản Về Docker Không Thể Bỏ Lỡ

Nhằm giúp bạn hiểu rõ hơn về Docker là gì, và thời điểm sử dụng thích hợp nhất, chúng tôi sẽ tổng hợp các kiến thức về phần mềm này trong bài viết dưới đây.

Nhắc đến nền tảng phần mềm hỗ trợ lập trình viên khai thác ứng dụng nhanh chóng thì không thể bỏ qua cái tên Docker. Nhằm giúp bạn hiểu rõ hơn về Docker là gì, và thời điểm sử dụng thích hợp nhất, chúng tôi sẽ tổng hợp các kiến thức về phần mềm này trong bài viết dưới đây. Mời bạn cùng tham khảo nhé.

## Docker dùng để làm gì?

Docker là một nền tảng phần mềm cung cấp cho lập trình viên giải pháp xây dựng, triển khai và vận hành ứng dụng dễ dàng, nhanh chóng thông qua việc sử dụng những container trên nền tảng công nghệ ảo hóa.

Hay nói cách khác, Docker là một nền tảng ở tầng OS, cho phép người dùng tinh chỉnh, và sử dụng nó để chạy ảo hóa ứng dụng, dịch vụ nhanh chóng.

Nếu như trước kia, quá trình sử dụng máy ảo triển khai ứng dụng gây tốn kém nhiều thời gian, thì hiện nay việc ứng dụng Docker đã giúp rút ngắn hơn nhiều.

Trong thời điểm mới giới thiệu đến thị trường, Docker được viết bằng ngôn ngữ Python. Tuy nhiên, hiện nay nó được chuyển sang ngôn ngữ Golang.

## Các khái niệm về Docker là gì?

### 1. Container trong Docker Linux là gì

Các container trong Docker hỗ trợ lập trình viên đóng gói ứng dụng và các thành phần cần thiết của nó như thư viện, các dữ liệu phụ thuộc… Tất cả chúng sẽ được đóng gói thành dạng một package.

Bằng cách này, ứng dụng có thể vận hành trên mọi máy chạy hệ điều hành Linux bất kể các tùy chỉnh cài đặt của thiết bị có thể khác với máy tính được dùng để viết code.

Có thể thấy, Docker tương đối giống với virtual machine nhưng mức độ phát triển, và phổ biến của nó nhanh chóng hơn nhờ vào các ưu điểm như:

- Tính dễ ứng dụng: Nó mang đến sự thuận lợi, dễ dàng cho người sử dụng. Bằng cách tận dụng điểm mạnh của container để xây dựng, kiểm tra một cách nhanh chóng. Bên cạnh đó, container còn đóng gói ứng dụng ngay trên máy tính, và dễ dàng vận hành trên nền tảng đám mây công cộng hoặc riêng biệt. 
- Tốc độ: Docker container nhẹ và nhanh. Chỉ với vài giây, bạn có thể thực hiện tạo và cho khởi chạy Docker container.
- Môi trường vận hành, khả năng mở rộng: Bạn được phép tùy ý chia nhỏ các chức năng của ứng dụng thành nhiều container riêng biệt. Docker sẽ tiến hành liên kết các container để tạo thành một ứng dụng hoàn chỉnh, giúp nó dễ dàng được cập nhật, scale những thành phần độc lập nhau. Ví dụ, Database vận hành trên một container riêng, Redis cache chạy trên một container khác.
- 

### 2. Tìm hiểu về Docker Swarm là gì? 

Docker Swarm là tập hợp một nhóm các máy chạy Docker để tạo thành một cluster. Sau khi được tập hợp vào Swam, tất cả các câu lệnh Docker sẽ được thực thi trên Swarm manager.

Các máy tham gia vào Swam có tên gọi là worker node. Các node không có quyền quản lý, chúng chỉ có khả năng cung cấp hoạt động.

Chức năng của Docker swarm là khởi chạy cho các container trên nhiều máy, hoặc trên duy nhất một máy. Phần mềm Docker swarm đóng vai trò quan trọng trong việc hỗ trợ tạo, quản lý các container cùng hệ thống container orchestration. Nó là một cluster mà người dùng có thể sử dụng Docker engine hay các node để triển khai, vận hành ứng dụng. 

Bên cạnh đó, Docker swarm còn cung cấp tính năng quản lý các container chạy trên môi trường phân tán, nhằm đảm bảo hoạt động của các container ổn định.

### 3. Khái niệm Kubernetes trong Docker là gì?

Khi tìm hiểu về kỹ thuật Docker là gì, chắc chắn bạn không thể bỏ qua khái niệm Kubernetes Docker. Kubernetes còn có tên gọi khác là K8s. Nó là một nền tảng quản lý có mã nguồn mở tự động hóa. Khi đó, quá trình scaling, triển khai ứng dụng được thực hiện dưới dạng container, hay còn gọi là container orchestration engine. Kubernetes loại bỏ những thao tác thủ công của quá trình mở rộng, triển khai các containerized applications.

Kubernetes orchestration cho phép người dùng xây dựng các ứng dụng mở rộng nhiều hơn container. Ngoài ra, nó còn lên lịch cho container ở trên một cụm, giúp cho việc mở rộng cũng như quản lý tình trạng container trở nên thuận tiện, dễ dàng.

### 4. Các khái niệm liên quan khác trong hệ thống Docker là gì?

Dưới đây là một số khái niệm khác mà bạn cần biết khi học Docker.

- Docker Engine: Đây là thành phần chính không thể bỏ qua của Docker. Nó tương tự như công cụ đóng gói ứng dụng
- Docker Hub: Là một kho thư viện hình ảnh của Docker. Với số lượng ảnh đến hàng nghìn tấm do cộng đồng cung cấp, Docker Hub sẽ giúp bạn nhanh chóng tìm được các hình ảnh cần dùng. Để sử dụng ảnh này, bạn chỉ việc kéo nó về rồi dùng với các config mong muốn.
- Images: Đây là khuôn mẫu được sử dụng để tạo container. Thông thường, hình ảnh được tạo dựa vào một hình ảnh sẵn có, và người dùng bổ sung thêm các tùy chỉnh. 
- Container: Đây là một sản phẩm của một image. Bạn có thể tạo, bắt đầu, dừng, di chuyển hoặc xóa container dựa vào Docker API hay Docker CLI.
- Docker Client: Đây là công cụ hỗ trợ quá trình giao tiếp với Docker host của người dùng.
- Docker Daemon: Tiếp nhận các yêu cầu của Docker clinet để quản lý Container, Image, Network, Volumes bằng REST API. Tất nhiên, giữa các Docker Daemon cũng có sự giao tiếp để phục vụ cho công tác quản lý các Docker Service.
- Dockerfile: Đây là một tệp chứa nội dung các hướng dẫn xây dựng một image.
- Volumes: Là thông tin dữ liệu được tạo sau khi khởi tạo một container.

## Lợi ích của Docker là gì?

Docker sở hữu một loạt các lợi ích như: 

- Nhanh chóng, thuận tiện: Nếu như việc thực hiện dịch vụ hay ứng dụng trên virtual machine tiêu tốn vài chục phút, thì sử dụng Docker chỉ mất vài phút. 
- Tiết kiệm tài nguyên tối đa: Mỗi Docker container chỉ làm tiêu hao tài nguyên khi nó được sử dụng. Trong trường hợp không được sử dụng thì lượng tài nguyên này được trả lại cho máy chủ host.
- Khả năng tự động cao: Quá trình khởi tạo hoặc tắt một Docker container dễ dàng nhờ vào các metric của hệ thống. Điều này giúp đáp ứng tối đa các nhu cầu đa dạng của người sử dụng. 
- Việc quản lý Docker container tự động: Quá trình quản lý Docker container thông thường đều do Kubernetes hay Docker Swarm đảm nhận.

## Thời điểm nên sử dụng Docker

Sau khi tìm hiểu về Docker, tiếp đến, bạn có thể cân nhắc sử dụng phần mềm này, bằng cách xem xét đã đến thời điểm phù hợp hay chưa. Dưới đây là những trường hợp lý tưởng để sử dụng Docker.

- Triển khai kiến trúc Microservices.
- Bạn xây dựng một ứng dụng cần scale linh hoạt.
- Bạn muốn rút ngắn thời gian để config máy local, và máy chủ trong cùng môi trường chạy ứng dụng.
- Bạn đang muốn có cách tiếp cận mới để xây dựng, triển khai ứng dụng trên máy chủ.

## Download Docker ở đâu?

Để tải phần mềm Docker về máy tính, bạn truy cập website chính thức của nhà phát triển rồi tìm phiên bản tương thích với hệ điều hành đang sử dụng, và download.

Link download: https://www.docker.com/products/personal 

## Quy trình thực thi hệ thống Docker

Thông thường, hệ thống Docker được thực thi qua 3 bước chính dưới đây: 

- Bước 1: Build
Bước đầu tiên của thực thi hệ thống Docker là bạn phải tạo một Dockerfile chứa code của ứng dụng hoặc dịch vụ. Nó được xây dựng tại một thiết bị được cài sẵn Docker engine. Sau khi hoàn tất build, bạn có được một container chứa ứng dụng, và bộ thư viện đi kèm.
- Bước 2: Push
Bạn tiến hành push container đã tạo ra ở bước 1 lên nền tảng đám mây và lưu trữ. 
- Bước 3: Pull và Run trong Docker là gì
Trong trường hợp có một máy tính hoặc thiết bị khác cần sử dụng container thì thiết bị này phải pull container về máy. Lưu ý, thiết bị bắt buộc phải được cài đặt Docker engine. Sau đó, bạn thực hiện tiếp thao thác Run container.