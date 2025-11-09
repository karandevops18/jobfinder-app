# jobfinder-app
Job Finder Web App is a full-stack project built with React (frontend) and Flask (backend). It showcases DevOps practices with Docker containerization, GitHub Actions CI/CD, and AWS ECS deployment. Designed for scalable, cloud-ready architecture using modern CloudOps workflows.
![AWS](https://img.shields.io/badge/AWS-ECS%20%7C%20ECR-orange?logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Containerization-blue?logo=docker)
![CI/CD](https://img.shields.io/badge/GitHub%20Actions-Automation-green?logo=githubactions)

# 🔍 Job Finder Web App

A **full-stack Job Search Platform** built with **React (frontend)** and **Flask (backend)** — allowing users to view, search, and filter job listings seamlessly.  

This project showcases **DevOps and CloudOps skills** by using **Docker**, **GitHub Actions CI/CD**, and **AWS ECS (Fargate)** for scalable, production-grade deployment.

---

## 🚀 Features

- 🧭 Browse and search job listings  
- 📝 Add and view job details  
- ⚙️ RESTful API built with Flask  
- 🐳 Containerized using Docker  
- ☁️ Deployed on AWS ECS (Fargate)  
- 🔄 Automated build and deploy via GitHub Actions  
- 💾 Persistent storage with SQLite (local) or PostgreSQL (AWS RDS)

---

## 🧰 Tech Stack

| Layer | Technology |
|-------|-------------|
| **Frontend** | React, Tailwind CSS |
| **Backend** | Flask (Python), Flask-CORS |
| **Database** | SQLite (local) / PostgreSQL (AWS RDS) |
| **CI/CD** | GitHub Actions |
| **Deployment** | AWS ECS (Fargate), ECR |
| **Monitoring** | Amazon CloudWatch |
| **Secrets** | AWS Secrets Manager |

---

## 🏗️ Architecture Overview

**AWS Components Used:**
- ECS (Fargate) for container orchestration  
- ECR for image storage  
- Application Load Balancer for routing (`/ → frontend`, `/api/* → backend`)  
- RDS for persistent data  
- CloudWatch for logs  
- Secrets Manager for secure credentials  
- S3 (optional) for static assets  
- GitHub Actions for CI/CD automation  

📊 **Architecture Diagram:**  
  

---<img width="1114" height="673" alt="Screenshot 2025-10-11 084639" src="https://github.com/user-attachments/assets/297ba5b8-7c62-4971-9d79-ae376e522b70" />


## ⚙️ Local Setup

### Prerequisites
- Node.js ≥ 18  
- Python ≥ 3.10  
- Docker Desktop  
- AWS CLI (for cloud deployment)  

### 1️⃣ Clone the repository
```bash
git clone https://github.com/<your-username>/job-finder-webapp.git
cd job-finder-webapp

2️⃣ Run Backend
cd backend
pip install -r requirements.txt
python app.py

3️⃣ Run Frontend
cd frontend
npm install
npm start

4️⃣ Access the App
Frontend: http://localhost:3000
Backend: http://localhost:5000/jobs

🐳 Docker Setup
# Frontend
docker build -t jobfinder-frontend ./frontend

# Backend
docker build -t jobfinder-backend ./backend

**Run Containers**
docker run -d -p 3000:3000 jobfinder-frontend
docker run -d -p 5000:5000 jobfinder-backend

⚙️ GitHub Actions CI/CD (AWS ECS)

Workflow:
1. Trigger on push to main branch
2. Build Docker images for frontend & backend
3. Push images to Amazon ECR
4. Deploy latest versions to AWS ECS (Fargate)

🛡️ Environment Variables

| Variable           | Description                   |
| ------------------ | ----------------------------- |
| `DATABASE_URL`     | Database connection string    |
| `FLASK_ENV`        | Environment (dev/prod)        |
| `AWS_REGION`       | AWS Region (e.g., ap-south-1) |
| `BACKEND_BASE_URL` | API base path                 |
| `S3_BUCKET_NAME`   | Optional for static assets    |

📈 Future Enhancements
👥 User authentication (Admin/User roles)
💼 Resume upload and job apply feature
📊 Integration with live job APIs
☁️ Infrastructure as Code (Terraform) automation
🌐 HTTPS & custom domain setup with Route 53 + ACM

🧾 License
This project is licensed under me – you’re free to modify and use it for learning or demonstration purposes.

💬 Author

Karan Singh Rajawat
💡 Passionate about DevOps, CloudOps & AI-driven automation
📫 Connect on [LinkedIn](https://www.linkedin.com/in/karanrajawat1801/)

If you liked this project, please ⭐ the repo and share feedback!

