# 🚀 Portfolio Website on AWS EKS with Terraform & GitHub Actions

This project deploys a personal **portfolio website** on **AWS Elastic Kubernetes Service (EKS)** using:

- **Terraform** → Infrastructure provisioning (EKS + ECR + VPC/Subnets)  
- **Docker** → Containerizing the portfolio website  
- **Amazon ECR** → Hosting the Docker image  
- **Kubernetes (EKS)** → Running the portfolio site  
- **GitHub Actions** → CI/CD automation  

---

## 📂 Project Structure
![Project Structure Diagram](images/project-structure.png)
   



---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.3`  
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configured  
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed  
- [Docker](https://www.docker.com/get-started) installed  
- AWS account with IAM user (Programmatic access, Admin/PowerUser policy)  

---

## 🔑 AWS Setup

**Locally:**  

aws configure
Enter your Access Key, Secret Key, and region (e.g., us-west-2).

GitHub Actions:
Go to GitHub → Repo → Settings → Secrets → Actions and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

ECR_REPOSITORY (from Terraform output)

EKS_CLUSTER_NAME

🏗️ Deploy Infrastructure (Terraform)


cd terraform
terraform init -upgrade
terraform plan
terraform apply -auto-approve
Configure kubectl to connect to cluster:


aws eks update-kubeconfig --region us-west-2 --name portfolio-eks
kubectl get nodes
🐳 Build & Push Docker Image
Get ECR URL:


terraform output ecr_repo_url
Login Docker to ECR:


aws ecr get-login-password --region us-west-2 \
| docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-west-2.amazonaws.com
Build & tag image:


docker build -t portfolio-site ./website
docker tag portfolio-site:latest <ecr_repo_url>:latest
docker push <ecr_repo_url>:latest
☸️ Deploy to Kubernetes
Apply Deployment & Service manifests:


kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods
kubectl get svc
Open your site in the browser using the EXTERNAL-IP from the service:


http://<EXTERNAL-IP>
Local testing (optional):


kubectl port-forward svc/portfolio-svc 8080:80
http://localhost:8080
🤖 CI/CD with GitHub Actions
Each push to the main branch triggers a workflow to:

Build & push Docker image to ECR

Deploy updated image to EKS

🧹 Cleanup (avoid AWS charges)

cd terraform
terraform destroy -auto-approve
📌 Notes
EKS requires at least t3.small nodes (not t2.micro).

Cluster creation can take ~15 minutes.

You can map a custom domain using Route53 and an ALB Ingress Controller.



