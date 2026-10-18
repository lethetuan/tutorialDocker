# Kubernetes – Phần 1 – Kubernetes là gì?

## Kubernetes là gì?

Kubernetes là một mã nguồn mở được dùng để tự động triển khai hệ thống, scaling, quản lý các container. Nó thực sự là một hệ thống mạnh mẽ, được phát triển bởi Google. Google sử dụng Kubernetes để quản lý hàng tỉ docker container mà họ đang quản lý.

Trang chủ: https://kubernetes.io/

## Ai cần Kubernetes?

- Các doanh nghiệp lớn, có nhu cầu thực sự phải scaling hệ thống nhanh chóng, và đã sử dụng container (Docker).
- Các dự án cần chạy >= 5 container CÙNG LOẠI cho 1 dịch vụ. (Ví dụ dùng >=5 máy cùng để chạy code website XYZ). Còn nhỏ hơn thì tốt nhất không dùng - đừng mang dao mổ trâu đi giết gà.
- Các startup hiện đại, chịu đầu tư vào công nghệ, để nhỡ về sau có to ra, thì to rất dễ 🙄
- Các sysadmin/DevOps muốn tăng lương, nhảy việc, vọc công nghệ mới.

## K8s là gì?

Lúc mới đầu mình cũng thắc mắc không biết K8s là gì? Tuy nhiên nó đơn giản chỉ là viết tắt của Kubernetes (K-8 chữ cái-s). Trang chủ của Kubernetes là https://k8s.io hay https://kubernetes.io/

## Kubernetes đọc thế nào?

Các bạn biết từ trên đọc thế nào không? Tôi đã thử tra từ điển nhưng cũng đành bó tay. Sau khi nhận được comment từ mọi người thì có vẻ tôi đã hiểu được đôi chút về ý nghĩa và cách đọc của Kubernetes:

- Ý nghĩa: "người lái tàu" trong tiếng Hy Lạp
- Cách đọc: Cu-ba-ni-tê-sờ

## Các hệ thống cung cấp Kubernetes cài đặt sẵn:

- Google container engine (GKE): https://cloud.google.com/container-engine/ (free 300$ cho tài khoản mới - dùng hết thì thôi cũng được)
- CoreOS techtonic: https://coreos.com/tectonic/
- RedHat Openshift: https://www.openshift.com/

## Các sản phẩm dựa trên Kubernetes

Cũng là nơi ta có thể nhìn rõ hơn K8s làm được gì, hay tìm tài liệu nếu trang chủ là không đủ:

- RedHat Openshift 3: https://www.openshift.org/
- Deis Workflow - opensource platform as a service (PaaS): https://deis.com/paas/
- Rancher - container management platform: http://rancher.com/rancher/

## Các cách để cài đặt K8s

K8s là một hệ thống, gồm nhiều thành phần tương tác với nhau. Tuy không tới nỗi phức tạp như cài một hệ thống cloud IaaS như OpenStack, nhưng cũng không phải chỉ gõ 3, 5 cái là xong. Vậy là người ta đẻ ra hàng chục cách khác nhau để cài K8s, đáng kể nhất có:

1. Minikube để cài 1 cluster test chơi chơi trên máy của bạn
2. Kubeadm đang trong giai đoạn phát triển, để cài trên hệ thống máy vật lý / máy ảo dùng Ubuntu 16.04 hay CentOS 7
3. Kargo là phần mềm dựa trên Ansible để cài trên rất nhiều nơi bao gồm cả máy vật lý/máy ảo/AWS/GCE
4. Dùng SaltStack để cài https://github.com/kubernetes/kubernetes/tree/master/cluster/saltbase/
5. Cài bằng tay trên CoreOS Container Linux
6. Kops để cài trên AWS (Amazon cloud)
7. Và rất nhiều các giải pháp khác nữa xem tại đây

## Các đối thủ cạnh tranh

- Docker Swarm https://docs.docker.com/engine/swarm/
- Apache Mesos https://mesos.apache.org/
- Google để được so sánh, ở đây không làm việc ấy