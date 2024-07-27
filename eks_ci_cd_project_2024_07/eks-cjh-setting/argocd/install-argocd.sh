### namespace 생성
kubectl create namespace argocd

### argocd 기본 설치(stable)
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

### argocd cli 설치
wget https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo cp argocd-linux-amd64 /usr/local/bin/argocd
rm -rf argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

### grpc 서비스 생성
kubectl apply -f grpc.yaml
### alb사용하는 ingress 생성
kubectl apply -f ingress.yaml

### argocd username: admin
### argocd 비밀번호
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo