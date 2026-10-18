# Microservices là gì? Từ A - Z về Microservices và Microservices Architecture

Các kỳ lân công nghệ hàng đầu thế giới điển hình như Netflix hay Twitter đều đang áp dụng phương pháp Microservices để phát triển các ứng dụng của mình. Vậy Microservices là gì? Hôm nay tôi sẽ hướng dẫn từ A - Z về Microservices và Microservices Architecture cho các bạn lần đầu tìm hiểu về phương pháp này trong bài viết dưới đây nhé!

*Microservices là gì mà các developers rất coi trọn trong phát triển phần mềm*

## 1. Microservices là gì?

Microservices là một phương pháp đặc biệt được ứng dụng trong phát triển hệ thống phần mềm. Phương pháp này sẽ cố gắng tập trung vào việc xây dựng các mô-đun đơn chức năng với các giao diện và hoạt động được xác định rõ ràng.

Microservices có nhiều lợi ích cho các nhóm Agile và DevOps. Lập trình viên kiêm diễn giả quốc tế Martin Fowler đã chỉ ra rằng: Netflix, eBay, Amazon, Twitter, PayPal và các ứng dụng công nghệ nổi tiếng khác đều đã phát triển từ kiến ​​trúc nguyên khối sang microservices. 

Microservices giải quyết những khó khăn của hệ thống nguyên khối bằng cách mô-đun hóa càng nhiều càng tốt. Ở dạng đơn giản nhất, microservices giúp xây dựng một ứng dụng dưới dạng một bộ các dịch vụ nhỏ, mỗi dịch vụ chạy trong quy trình riêng và có thể triển khai độc lập. Các dịch vụ này có thể được viết bằng các ngôn ngữ lập trình khác nhau và có thể sử dụng các kỹ thuật lưu trữ dữ liệu khác nhau. Các dịch vụ vi mô thường được kết nối thông qua API và có thể tận dụng nhiều công cụ và giải pháp tương tự đã phát triển trong hệ sinh thái dịch vụ web và RESTful. 

## 2. Lợi ích của phương pháp microservices 

Microservices ngày càng được sử dụng phổ biến tại các doanh nghiệp sản xuất phần mềm nhờ mang lại một số lợi ích như: 

* **Mã nguồn tinh gọn:** Bởi vì hệ thống được cấu hình từ các dự án nhỏ và mỗi dự án đều rất đơn giản cũng như tập trung vào một hoặc một số nghiệp vụ chính. Vì vậy, code base và độ phức tạp của chúng đều không cao. Nhờ vậy, nó sẽ giúp các tính năng vận hành mượt mà, dễ dàng hơn trong bảo trì hay mở rộng phát triển.
* **Tối ưu hóa bảo mật cho mã nguồn:** Việc nhân viên ở dự án nào chỉ được truy cập vào một mã nguồn của dự án đó sẽ đảm bảo khả năng kiểm soát dữ liệu tốt hơn.
* **Được tồn tại độc lập:** Khi có 4 dự án khác nhau và được triển khai riêng biệt nhưng một dịch vụ nào đó chết thì các dịch vụ khác vẫn sẽ hoạt động bình thường.
* **Scale hoàn toàn độc lập:** Tùy vào nhu cầu sử dụng của hệ thống mà bạn có thể mở rộng quy mô riêng cho dịch vụ đó. Ví dụ như đơn hàng dịch vụ mà sử dụng thường xuyên nên chạy từ máy chủ 2 đến 3 để gia tăng hiệu suất.

*Đặc điểm Microservices Architecture (Kiến trúc Microservices)*

## 3. Microservice architecture  

Không có định nghĩa chính thức về thuật ngữ microservice architecture haykiến trúc microservices là gì, cũng như không có mô hình tiêu chuẩn nào trình bày về phong cách cách kiến trúc này. Tuy vậy, hầu hết các kiến trúc microservice đều có chung một vài đặc điểm đáng chú ý:

* Phần mềm được xây dựng dưới dạng kiến trúc microservices có thể được chia thành nhiều dịch vụ thành phần.
* Hoạt động giống như hệ thống UNIX cổ điển: Nhận các yêu cầu, xử lý chúng và tạo ra một phản hồi tương ứng. 
* Có phương pháp quản trị phi tập trung hỗ trợ tạo ra các công cụ hữu ích để giải quyết các vấn đề khó khăn.
* Hướng đến sự toàn diện, microservices được thiết kế để đối phó với thất bại.
* Kiến trúc Microservices là một thiết kế tiến hóa và một lần nữa, lý tưởng cho các hệ thống tiến hóa, nơi bạn không thể lường trước đầy đủ các loại thiết bị có thể một ngày nào đó sẽ truy cập vào ứng dụng của bạn…
* Phong cách kiến trúc microservices thường được các doanh nghiệp ưu tiên sử dụng. 

## 4. 6 điều cần tuân thủ khi thiết kế kiến trúc Microservices 

Khi thiết kế Microservices Architecture, developer cần tuân thủ 6 điều sau để xây dựng được kiến trúc chất lượng:

a. Single Responsibility Principle (SRP): Nguyên tắc của một service là có phạm vi và chức năng giới hạn, tập trung vào một nhiệm vụ để quá trình phát triển và triển khai dịch vụ trở nên nhanh chóng hơn.

b. Trong quá trình thiết kế, bạn nên xác định và giới hạn các services theo chức năng nghiệp vụ thực tế.

3. Đảm bảo microservices có thể phát triển và triển khai độc lập thành từng module.

4. Mục tiêu của thiết kế của microservices sẽ phục vụ một nghiệp vụ chứ không chỉ đơn giản làm các dịch vụ nhỏ hơn. 

5. Kích thước hợp lý của một service là kích thước đủ để đáp ứng yêu cầu của một chức năng trong hệ thống.

6. Một microservice không nên có quá nhiều hàm hay chức năng hỗ trợ xung quanh và định dạng thông báo/ messaging đơn giản.

*Xây dựng kiến trúc Microservices cần tuân thủ một số nguyên tắc nhất định.*

## 5. Ưu điểm & nhược điểm của Microservices

Tuy là phương pháp được sử dụng hàng đầu trong phát triển phần mềm, Microservices vẫn còn tồn tại cả nhiều nhược điểm bên cạnh những ưu điểm nổi trội của nó.

### a. Ưu điểm của Microservices

* Dễ dàng phân phối và triển khai các ứng dụng lớn và phức tạp.
* Có thể cải thiện khả năng bảo trì nhờ các service có đặc điểm tương đối nhỏ, dễ hiểu và dễ thay đổi. 
* Kiểm thử dễ dàng, phát hiện bug sớm khi các services có quy mô nhỏ.
* Có thể triển khai tốt hơn: các services thường rất dễ cho việc triển khai độc lập. 
* Cho phép các services được phát triển nhanh chóng bởi những team khác nhau. Khi đó, mỗi team đều sẽ được phát triển và thử nghiệm để triển khai cũng như mở rộng được quy mô của dịch vụ của mình một cách độc lập nhất với tất cả các team. 
* Nếu như có lỗi xảy ra trong một service thì chỉ có service đó bị ảnh hưởng và các service khác sẽ thực hiện xử lý các yêu cầu cần thiết. Trong khi đó, thì mỗi một thành phần nếu như hoạt động sai của kiến trúc một khối thì nó sẽ làm ảnh hưởng đến toàn bộ hệ thống. 
* Lập trình viên có thể thay đổi dễ dàng bằng cách sử dụng công nghệ mới khi triển khai các service. Tương tự như khi có thay đổi lớn thì các service đều có thể thực hiện và bạn dễ dàng thay đổi được công nghệ hơn. 

*Microservices dễ dàng phân phối và triển khai các ứng dụng lớn và phức tạp.*

### b. Nhược điểm của Microservices

* Nhà phát triển thường xuyên phải đối phó với sự phức tạp khi tạo ra một hệ thống phân tán. 
* Cần phải implement việc communication giữa các inter-services
* Handle partial failure rất phức tạp bởi vì luồng xử lý cần phải đi qua nhiều service khác nhau. 
* Khi thực hiện các requests trải rộng trên nhiều service cần đòi hỏi sự phối hợp giữa các team. 
* Khó khăn trong việc đảm bảo toàn vẹn cho cơ sở dữ liệu nếu như triển khai theo các cấu trúc dạng phân vùng. 
* Việc triển khai và quản lý microservices nếu như làm thủ công theo cách làm với ứng dụng thì sẽ rất phức tạp.
* Lập trình viên cần phải xử lý các sự cố kết nối chậm, lỗi nếu như thông điệp không được gửi hoặc nếu như thông điệp được gửi đến nhiều đích đến vào các thời điểm khác nhau. 

## Tổng kết

Với các kiến thức tổng quan mà tôi chia sẻ ở phía trên thì bạn đã hiểu rõ được Microservices là gì, các lợi ích mà Microservices mang lại, cũng như ưu điểm và nhược điểm của phương pháp này, bên cạnh thông tin về kiến trúc Microservices. Hy vọng rằng, các bạn developers sẽ hiểu và áp dụng được phương pháp Microservices vào công việc phát triển phần mềm tương lai.