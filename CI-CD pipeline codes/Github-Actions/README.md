🔐 Required GitHub Secrets (Repository → Settings → Secrets → Actions)

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION (e.g. us-east-2)
AWS_ACCOUNT_ID (12-digit)
ECR_FE_REPO (e.g. jobfinder-frontend)
ECR_BE_REPO (e.g. jobfinder-backend)
ECS_CLUSTER (e.g. jobfinder-prod)
ECS_SERVICE_FRONTEND (e.g. jobfinder-prod-frontend-svc)
ECS_SERVICE_BACKEND (e.g. jobfinder-prod-backend-svc)

Make sure your ECS task definitions have containers named exactly frontend and backend (or change the names in the workflow where marked).

Put your pipeline file at **.github/workflows**/filename.yml in your repo
