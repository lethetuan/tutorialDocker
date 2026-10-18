Kubernetes – Phần 3 – Cài đặt Kubernetes

- MỤC LỤC
- Triển khai hệ thống Kubernetes
- Sử dụng Kubeadm để deploy cho hệ thống thật
- Sử dụng Minikube để deploy trên localhost

Triển khai hệ thống Kubernetes

Như tôi đã giới thiệu ở phần 1 chúng ta có nhiều cách để deploy Kubernetes, tuy nhiên trong bài viết này mình chỉ hướng dẫn các bạn theo 2 cách dưới đây.

Note: Mình sử dụng hệ điều hành Ubuntu

Sử dụng Kubeadm để deploy cho hệ thống thật

Phương pháp này có thể deploy trên các nền tảng sau: AWS, GCE, Azure, Joyent, OpenStack, VMWare, Bare Metal and localhost. Kubeadm được hỗ trợ chính thức bởi Kubernetes, do vậy chúng ta sẽ sử dụng phương pháp này để deploy cho hệ thống thật. Việc setup cực kỳ đơn giản, chúng ta chỉ cần chạy command sau:

```bash
sudo snap install conjure-up --classic conjure-up kubernetes
```

Một màn hình giao diện đơn giản hiện lên và bạn hãy làm theo hướng dẫn trong đó. Dưới đây là một video hướng dẫn setup Kubernetes thông qua Kuberadm classic, không sử dụng giao diện.

Sử dụng Minikube để deploy trên localhost

Minikube cần sử dụng VirtualBox để tạo node, do đó việc đầu tiên chúng ta phải làm đó là cài đặt VirtualBox

```bash
sudo apt-get install virtualbox
```

- Cài đặt minikube
```bash
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.18.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```

- Cài đặt kubectl
```bash
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.6.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/
```

- Khởi động Cluster
```bash
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.18.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$ minikube start 
Starting local Kubernetes cluster... 
Starting VM... 
SSH-ing files into VM... 
Setting up certs... 
Starting cluster components... 
Connecting to cluster... 
Setting up kubeconfig... 
Kubectl is now configured to use the cluster.
```

- Kiểm tra danh sách các Pod
```bash
$ kubectl get pods --all-namespaces 
NAMESPACE     NAME                                    READY     STATUS    RESTARTS   AGE 
kube-system   kube-addon-manager-minikube             1/1       Running   0          9h 
kube-system   kube-dns-v20-kqlbc                      3/3       Running   0          9h 
kube-system   kubernetes-dashboard-52wwl              1/1       Running   0          9h
```

- Kiểm tra danh sách Node
```bash
$ kubectl get nodes 
NAME       STATUS    AGE     VERSION 
minikube   Ready     24m     v1.6.0
```

- Kiểm tra danh sách docker container
```bash
$ docker ps 
CONTAINER ID   IMAGE                                                 COMMAND                  CREATED          STATUS          PORTS   NAMES 
d271e008a309   93a43bfb39bf                                          "/exechealthz '--c..."   26 minutes ago   Up 26 minutes           k8s_healthz_kube-dns-v20-7hn9d_kube-system_557327c7-1d44-11e7-9049-5254001b4720_0 
1d6710f4e2e4   3ec65756a89b                                          "/usr/sbin/dnsmasq..."   26 minutes ago   Up 26 minutes           k8s_dnsmasq_kube-dns-v20-7hn9d_kube-system_557327c7-1d44-11e7-9049-5254001b4720_0 
0291e09a264f   26cf1ed9b144                                          "/kube-dns --domai..."   26 minutes ago   Up 26 minutes           k8s_kubedns_kube-dns-v20-7hn9d_kube-system_557327c7-1d44-11e7-9049-5254001b4720_0 
57ad697d2dec   416701f962f2                                          "/dashboard --port..."   26 minutes ago   Up 26 minutes           k8s_kubernetes-dashboard_kubernetes-dashboard-zbnj4_kube-system_54b5857e-1d44-11e7-9049-5254001b4720_0 
c2504223e7ea   gcr.io/google_containers/pause-amd64:3.0              "/pause"                 27 minutes ago   Up 27 minutes           k8s_POD_kube-dns-v20-7hn9d_kube-system_557327c7-1d44-11e7-9049-5254001b4720_0 
903e6044ae1a   gcr.io/google_containers/pause-amd64:3.0              "/pause"                 27 minutes ago   Up 27 minutes           k8s_POD_kubernetes-dashboard-zbnj4_kube-system_54b5857e-1d44-11e7-9049-5254001b4720_0 
f848bb9dc40e   9da55e306d47                                          "/opt/kube-addons.sh"    27 minutes ago   Up 27 minutes           k8s_kube-addon-manager_kube-addon-manager-minikube_kube-system_4fb35b6f38517771d5bfb1cffb784d97_0 
80b467aee7e7   gcr.io/google_containers/pause-amd64:3.0              "/pause"                 28 minutes ago   Up 28 minutes           k8s_POD_kube-addon-manager-minikube_kube-system_4fb35b6f38517771d5bfb1cffb784d97_0
```

- Dừng Cluster
```bash
$ minikube stop 
Stopping local Kubernetes cluster... 
Machine stopped.
```

- Xóa Cluster
```bash
$ minikube delete 
Deleting local Kubernetes cluster... 
Machine deleted.
```

- Truy cập Kubernetes dashboard:
```bash
$ minikube dashboard 
Opening kubernetes dashboard in default browser...
```