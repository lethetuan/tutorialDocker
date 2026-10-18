Kubernetes – Phần 2 – Kiến trúc Kubernetes

Mục lục
- Mục tiêu
- Kiến trúc
- Master server
- Etcd
- API Server
- Controller Manager Service
- Scheduler Service
- Dashboard (optional)
- Node Server
- Pod
- Service (svc)
- Persistent Volumes
- Namespaces
- Ingress rules
- Network policies
- Network
- ConfigMaps and Secrets
- Controllers
- Helm - K8s package manager
- Dashboard
- Monitoring
- Create
- Tổng kết
Mục tiêu
Trong bài viết này chúng ta sẽ tìm hiểu về các thành phần trong Kubernetes. Nhiệm vụ chính của từng phần là gì? K8s đưa ra một lô 1 lốc các khái niệm. Vậy nên muốn dùng k8s, phải nắm chắc các khái niệm.
Kiến trúc
K8s cluster bao gồm nhiều node, trên mỗi node sẽ cần chạy một "kubelet", đây là chương trình để chạy k8s. Cần một máy để làm "chủ" cluster, trên đó sẽ cài API server, scheduler ... Các máy còn lại sẽ chạy kubelet để sinh ra các container.
Master server

Etcd
Có thể liên kết cài đặt với từng node thông qua etcd.
API Server
Đúng theo tên gọi, đây chính là server cung cấp Kubernetes API. Nó có nhiệm vụ đặt Pod vào Node, đồng bộ hoá thông tin của Pod bằng REST API tiếp nhận cài đặt của pod/service/replicationController.
Controller Manager Service
Được hiểu giống như “kube-controller manager”, nó quản lý tất cả các bộ điều khiển xử lý các tác vụ thông thường trong cluster. Chúng bao gồm Node Controller, Replication Controller, Endpoints Controller, and Service Account and Token Controllers. Chi tiết của các hoạt động này được ghi vào etcd, nơi controller manager theo dõi sự thay đổi thông qua API Server.
Scheduler Service
Scheduler Service có trách nhiệm giám sát việc sử dụng tài nguyên trên mỗi máy chủ để đảm bảo rằng hệ thống không bị quá tải. Scheduler Service phải biết tổng số tài nguyên có sẵn trên mỗi máy chủ, cũng như các tài nguyên được phân bổ cho các khối lượng công việc hiện có được gán trên mỗi máy chủ.
Dashboard (optional)
Giao diện web Kubernetes giúp đơn giản hóa các tương tác của người dùng Kubernetes cluster với máy chủ API.
Node Server

Pod
Pod là 1 nhóm (1 trở lên) các container thực hiện một mục đích nào đó, như là chạy software nào đó. Nhóm này chia sẻ không gian lưu trữ, địa chỉ IP với nhau. Pod thì được tạo ra hoặc xóa tùy thuộc vào yêu cầu của dự án.  Nếu k8s chỉ có mỗi khái niệm pod, thì dùng k8s giống như dùng docker bình thường. Tức muốn thêm tính năng gì thì ta phải tự kiến trúc/ thiết kế/ thực hiện. Các thông tin bạn cần về pod, nằm trong output của lệnh : describe pod PODNAME
$ kubectl get pods --selector='app=audit' NAME READY STATUS RESTARTS AGE audit-deployment-3585156150-mlcv3 1/1 Running 0 14d $ kubectl describe pod audit-deployment-3585156150-mlcv3 Name: audit-deployment-3585156150-mlcv3 Namespace: default
Service (svc)
Vì các Pod có tuổi thọ ngắn, do vậy nó không đảm bảo về địa chỉ ip luôn cố định. Điều này khiến cho việc giao tiếp giữa các microservice trở nên khó khăn. Do đó, K8s giới thiệu về một dịch vụ, nó là một lớp nằm trên một số nhóm Pod. Nó được được gắn địa chỉ IP tĩnh và có thể trỏ domain vào dịch vụ này. Tại đây chúng ta có thể thực hiện cân bằng tải. Mỗi service sẽ được gán 1 domain do người dùng lựa chọn, khi ứng dụng cần kết nối đến service, ta chỉ cần dùng domain là xong. Domain được quản lý bởi hệ thống name server SkyDNS nội bộ của k8s - một thành phần sẽ được cài khi ta cài k8s.
kubectl get svc --namespace=kube-system | grep dns kube-dns 10.3.240.10 <none> 53/UDP,53/TCP 38d
Tất nhiên, nếu chỉ có 1 máy chạy 1 dịch vụ, thì service chả có nghĩa lý gì. Vậy nên khi dùng k8s, hãy nhớ rằng nó được thiết kế và đưa vào các khái niệm để phục vụ cho hàng trăm, ngàn service/container, chứ không phải 1 cái. Nó phức tạp vì nó có lý do để phức tạp. Và bạn/công ty của bạn không phải Google (ở đây không hạ thấp bạn hay công ty của bạn), không phải công ty nào cũng chạy dịch vụ software cung cấp cho cả thế giới.
Persistent Volumes
Bất kỳ ai làm container cũng cần hiểu rằng, ta không lưu dữ liệu trên container mà phải lưu nó vào một chỗ nào đó. Bởi khi container restart / bị die thì dữ liệu cũng sẽ mất theo nó. Đây là chuyện dù dùng docker trực tiếp hay giải pháp khác K8s thì bạn vẫn phải tính. Việc lưu dữ liệu của app trên container trực tiếp trên máy host là một giải pháp nhỏ lẻ. Vì nếu ta cho dữ liệu của pod của app A vào /var/lib/app/A, mà có 2 pod cho app A cùng được chạy trên máy đó thì chuyện gì xảy ra? Giải pháp k8s sử dụng là các hệ thống lưu trữ "network". Tức lưu vào một hệ thống storage khác. Như NFS, GlusterFS, Ceph ... PV, là khái niệm để đưa ra một dung lượng lưu trữ THỰC TẾ 1GB, 10GB ... PVC là khái niệm ảo, đưa ra một dung lượng CẦN THIẾT, mà ứng dụng yêu cầu. Khi 1 PV thoả mãn yêu cầu của 1 PVC thì chúng "match" nhau, rồi "bound" (buộc / kết nối) lại với nhạu. Nếu tự cài K8s, hãy chuẩn bị sẵn giải pháp lưu trữ của bạn. Nếu dùng sẵn Google cloud hay AWS, sẵn sàng để trả tiền. Kubernetes hỗ trợ nhiều kiểu volumes, như là: NFS, Ceph, GlusterFS, local directory, ...
Namespaces
Đây là một công cụ dùng để nhóm hoặc tách các nhóm đối tượng. Namespaces được sử dụng để kiểm soát truy cập, kiểm soát truy cập network, quản lý resource và quoting.

Nếu tôi đặt service này là "web" lúc chạy production, còn lúc dev thì tôi chạy nó ở đâu? không nhẽ phải đổi tên service? Namespace giải quyết vấn đề này. Mặc định các dịch vụ sẽ sử đụng namespace "default", nhưng ta muốn tạo namespace nào thì tuỳ ý. K8s sử dụng 1 namespace riêng : kube-system, vì vậy nhớ đừng quên namespace khi gọi câu lệnh:
$ kubectl get svc --namespace=kube-system NAME CLUSTER-IP EXTERNAL-IP PORT(S) AGE default-http-backend 10.3.246.86 <nodes> 80:31031/TCP 38d elasticsearch-logging 10.3.251.158 <none> 9200/TCP 33d heapster 10.3.242.120 <none> 80/TCP 33d kibana-logging 10.3.245.215 <none> 5601/TCP 33d kube-dns 10.3.240.10 <none> 53/UDP,53/TCP 38d kubernetes-dashboard 10.3.243.251 <none> 80/TCP 33d monitoring-grafana 10.3.243.34 <none> 80/TCP 33d monitoring-influxdb 10.3.253.47 <none> 8086/TCP 33d tiller-deploy 10.3.240.33 <none> 44134/TCP 38d
Ingress rules
Dùng để quản lý network ra và vào các service và pod
Network policies
Định nghĩa các quy tắc truy cập mạng giữa các Pod bên trong Cluster.
Network
Có nhiều loại phần mềm để triển khai container network, như Flannel, Weaver ... nếu bạn dùng Google Cloud, vấn đề này không cần quan tâm.
ConfigMaps and Secrets
Một software ít khi chạy luôn mà không cần config. ConfigMap là giải pháp để nhét 1 file config / đặt các ENVironment var hay set các argument khi gọi câu lệnh. ConfigMap là một cục config, mà pod nào cần, thì chỉ định là nó cần - giúp dễ dàng chia sẻ file cấu hình. Ít ai muốn đặt mật khẩu vào file cấu hình, và chỉ có lập trình viên "tồi" mới hardcode mật khẩu vào code. Vậy nên K8s có "secret", để lưu trữ các mật khẩu, token, ... hay những gì cần giữ bí mật.
Controllers
Các "khái niệm" khác nhau cho các loại dịch vụ khác nhau.
1. Deployment : là loại chung nhất, khi ta muốn "deploy" một dịch vụ nào đó. Ta tạo ra pod bằng cách tạo ra một deployment (hoặc statefulSets, hoặc các khái niệm tương đương). StatefulSets được dùng khi ta cần các service bật lên theo tứ tự nhất định.
2. DaemonSet : thường dành cho các dịch vụ cần chạy trên tất cả các node. Ví dụ như fluentd để collect log trên tất cả các node.
3. StatefulSet : là 1 file "manifest" đặt trong thư mục chỉ định bởi kubelet, các pod này sẽ được chạy khi kubelet chạy. Không thể điều khiển chúng bằng kubectl. Đây là một khái niệm đang dần bị xa lánh bởi sự thiếu linh động và khó kiểm soát.
Gõ kubectl get để xem tất cả những khái niệm resource mà k8s sử dụng, và cách gọi ngắn gọn cho từng khái niệm (svc cho service, deploy cho deployment, cm cho configmap ...).
Helm - K8s package manager
Trên Ubuntu, ta dùng APT để cài package, thì trên K8s, Helm dùng để cài các "chart", muốn chạy một hệ thống CI ? Install ngay bằng câu lệnh của helm. helm install something
$ helm install stable/concourse # cài concourse CI
Dashboard
Dashboard cho phép xem tổng quan về cluster k8s đang dùng, nó được cài vào k8s như một add-on https://github.com/kubernetes/dashboard Nói chung là để xem thôi, còn tương tác gì thì cứ câu lệnh kubectl mà chọc. Kiểm tra xem đã cài dashboard chưa:
$ kubectl get svc --namespace=kube-system | grep -i dashboard kubernetes-dashboard 10.3.243.251 <none> 80/TCP 38d
Truy cập:
$ kubectl proxy
Starting to serve on 127.0.0.1:8001 Vào trình duyệt qua 127.0.0.1:8001/ui/

Monitoring
Monitoring trên K8s rất dễ dàng, chỉ cần cài 1 phần mềm có khả năng tích hợp với k8s, nó sẽ hỏi K8s để lấy thông tin về tất cả các pod trong hệ thống.Hãy tưởng tượng ta có hệ thống monitoring tự động cho mọi pod được tạo - mà không cần làm gì :3 Xem thêm tại https://kubernetes.io/docs/concepts/cluster-administration/resource-usage-monitoring/
Create
Mọi file cấu hình cho pod/svc/cm/ ... đều là file ở định dạng YAML. Chỉ cần chạy
kubectl create -f filename # hoặc . để cài hết các file trong thư mục hiện tại
để deploy chúng.
Tổng kết
- Nếu bạn sẵn sàng chi tiền để mua K8s chạy trên một hệ thống dựng sẵn nào đó: như GCE hay OpenShift, thì mọi vấn đề liên quan đến cài đặt k8s cùng các thành phần khác sẽ được bỏ qua, bạn chỉ cần quan tâm tới việc vận hành các pod/service của mình, và trả tiền.
- CoreOS có nhiều đóng góp và doc khá tốt để giới thiệu và tự cài 1 hệ thống K8s: https://coreos.com/kubernetes/docs/latest/