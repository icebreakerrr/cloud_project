# 하단 명령어 실행 전 alb controller policy 생성 할 것
# cluster-name은 자신이 사용중인 cluster-name을 입력
# policy-arn: alb-controller-policy arn you made by terraform code
eksctl create iamserviceaccount \
  --name alb-iamserviceaccount \
  --namespace kube-system \
  --cluster team5-eks \
  --attach-policy-arn arn:aws:iam::767397906204:policy/team5-alb-controller-policy \
  --approve \
  --override-existing-serviceaccounts

# Helm Chart를 이용하여 alb-ingress-controller를 배포
# cluster-name은 자신이 사용중인 cluster-name을 입력
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
     --set clusterName=team5-eks \
     --set serviceAccount.create=false \
     --set serviceAccount.name=alb-iamserviceaccount \
     --set extraArgs={--cloud-provider=aws} \
     -n kube-system