# Kubernetes – Phần 4 – Namespace là gì?

Qua các phần trước, chúng ta đã tìm hiểu về nguồn gốc ra đời, kiến trúc các thành phần và cách thức cài đặt một cụm hạ tầng Kubernetes bằng kubeadm. Bây giờ chúng ta sẽ cùng tìm hiểu một số khái niệm cơ bản trong Kubernetes để giúp các bạn có thể quản trị và vận hành được một hạ tầng Kubernetes.

Giả sử bạn được bàn giao một hạ tầng Kubernetes để vận hành, quản trị thì bạn sẽ cần tiếp cận cái gì đầu tiên?

Tùy vào kiến thức nền và vị trí công việc của mỗi bạn mà có các câu trả lời khác nhau. Nếu bạn được bàn giao tài khoản quản trị Kubernetes cluster, bạn sẽ cần biết hạ tầng Kubernetes được cài đặt bằng cách thức nào, có HA hay không, mức độ khai thác tài nguyên ra sao, đang dùng storage gì, tích hợp với các hệ thống nào, có bao nhiêu ứng dụng đang triển khai trên đó, triển khai trên các namespace nào,… Còn nếu bạn là người triển khai ứng dụng thì bạn quan tâm tới việc đang bị limit resource ra sao, tài khoản được cấp quyền gì, có storageclass không, có những policy nào phải tuân thủ, namespace được cấp tên là gì,….

OK. Bài này chúng ta sẽ cùng nhau tìm hiểu một khái niệm đầu tiên khi làm việc với Kubernetes, đó là namespace. Vậy namespace là gì? Các bạn sẽ thấy khái niệm namespace xuất hiện ở khá nhiều nơi, nhưng có cùng chung một mục đích: Một vùng không gian riêng.

Các bạn hẳn rất quen thuộc với thuật ngữ folder (thư mục) trong hệ điều hành Windows, Linux, vậy trong Kubernetes có thể hiểu về mặt logic thì namespace như một folder. Nhưng folder này trong Kubernetes nó trải dài trên tất cả các node. Bạn không thể tạo được hai tập tin (file) có trùng tên trong cùng một thư mục (folder), thì tính chất này cũng tương tự trong namespace, nhưng thay vì là tập tin thì trong namespace sẽ được đặt các resource.

Resource: Được hiểu là một loại tài nguyên được kubernetes quản lý như pods, volume, service, serviceaccount, configMap, secret,… Các resource này sẽ được mình làm rõ ở các bài tiếp theo. Bản thân namespace cũng được coi là một resource.

Một hình minh họa cho các bạn dễ hiểu về namespace (nguồn từ quyển sách Kubernetes security):

Hình 1: Phạm vi của Namespace trong Kubernetes

Theo như hình trên, nhìn tổng quát từ bên ngoài Kubernetes vào thì sẽ thấy:
- Một Kubernetes Cluster sẽ bao gồm rất nhiều node (master, worker).
- Một namespace trong Kubernetes Cluster sẽ nằm trên tất cả các node.
- Mọi ứng dụng khi triển khai trong Kubernetes phải thuộc vào một namespace nào đó.

Namespace là một thành phần logic mà tất cả mọi người đều phải hiểu và tương tác nếu làm việc với Kubernetes.

Mặc định khi cài đặt xong một cụm Kubernetes ta sẽ có 03 namespace: kube-system, default, public.

Nếu bạn đang nắm quyền quản trị (admin) thì bạn có thể tạo một namespace tên là test bằng cách chạy lệnh sau:
```bash
kubectl create namespace test
```

Namespace trong Kubernetes còn có một cách viết ngắn gọn là ns. Bạn kiểm tra các namespace đang có trong hạ tầng Kubernetes bằng lệnh:
```bash
kubectl get ns
```

Khi muốn tương tác với các resource trong namespace thì các bạn thêm tham số -n [NAMESPACE] vào câu lệnh:
```bash
kubectl -n kube-system get all
```

Để xem những resource nào thuộc Kubernetes nằm trong phạm vi của namespace thì ta dùng lệnh:
```bash
kubectl api-resources --namespaced=true
```

Ngoài ra, còn một số kiến thức khác về liên quan tới namespace nữa như: thiết lập label cho namespace, phân giải service name giữa các namespace khi kết nối sẽ được mình đề cập tới trong các bài viết sau.

Tóm lại:
1. Namespace là một thành phần logic được Kubernetes sử dụng để xác định phạm vi quản lý các resource.
2. Một resource trong cùng một namespace không thể đặt tên giống nhau.