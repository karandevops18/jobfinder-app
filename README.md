<h1 align="center">🔍 Job Finder Web App</h1>

<p align="center">
  A <b>full-stack Job Search Platform</b> built with <b>React</b> (frontend) and <b>Flask</b> (backend),
  demonstrating complete <b>DevOps automation</b> using <b>Docker</b>, <b>GitHub Actions</b>, and <b>AWS ECS</b>.
</p>

---

## ✨ Project Overview

**Job Finder Web App** allows users to browse, search, and view job listings in a clean, responsive UI.  
It’s designed as a **DevOps + CloudOps showcase project**, combining containerization, CI/CD, and AWS deployment to demonstrate real-world production architecture.

---

## 🧠 Features

- 🔎 Browse & search job listings  
- 📝 View detailed job information  
- 🐳 Dockerized frontend & backend services  
- ⚙️ CI/CD automated with GitHub Actions  
- ☁️ Deployment on AWS ECS (Fargate)  
- 🛢️ Persistent data with AWS RDS (PostgreSQL)  
- 🔐 Secrets & credentials via AWS Secrets Manager  
- 📊 Monitoring via Amazon CloudWatch  

---

## 🧰 Tech Stack

<p align="center">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/react/react-original-wordmark.svg" alt="React" width="60" height="60"/>
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original-wordmark.svg" alt="Python" width="60" height="60"/>
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original-wordmark.svg" alt="Docker" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/githubactions/githubactions-original.svg" alt="GitHub Actions" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="AWS" width="80" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original-wordmark.svg" alt="PostgreSQL" width="60" height="60"/>
</p>

| Layer | Technology |
|-------|-------------|
| **Frontend** | React, Tailwind CSS |
| **Backend** | Flask (Python), Flask-CORS |
| **Database** | PostgreSQL (AWS RDS) |
| **Containerization** | Docker |
| **CI/CD** | GitHub Actions |
| **Deployment** | AWS ECS (Fargate), ECR |
| **Monitoring** | CloudWatch |
| **Secrets Management** | AWS Secrets Manager |

---

## 🏗️ Architecture Overview

**AWS Components Used:**
- **Amazon ECS (Fargate)** – Runs frontend & backend containers  
- **Amazon ECR** – Stores Docker images  
- **Application Load Balancer (ALB)** – Routes `/ → frontend`, `/api/* → backend`  
- **Amazon RDS (PostgreSQL)** – Persistent job storage  
- **AWS Secrets Manager** – Secures DB credentials  
- **Amazon CloudWatch** – Logs & monitoring  
- **GitHub Actions** – Automates build, push, deploy

  
📊 **Architecture Diagram:**  
  
<img width="1114" height="673" alt="Screenshot 2025-10-11 084639" src="https://github.com/user-attachments/assets/297ba5b8-7c62-4971-9d79-ae376e522b70" />


## ⚙️ Local Setup

### Prerequisites
- Node.js ≥ 18  
- Python ≥ 3.10  
- Docker Desktop  
- AWS CLI (for cloud deployment)  

### 1️⃣ Clone the repository
```bash
git clone https://github.com/karandevops18/jobfinder-app.git
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

