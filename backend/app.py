from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# In-memory storage for jobs (mock data)
jobs = [
    {
        "id": 1,
        "title": "Senior Python Developer",
        "company": "TechCorp Inc.",
        "location": "San Francisco, CA",
        "salary": "$120,000 - $150,000",
        "type": "Full-time",
        "description": "We are looking for an experienced Python developer to join our backend team. You will work on building scalable APIs and microservices."
    },
    {
        "id": 2,
        "title": "Frontend React Developer",
        "company": "StartupXYZ",
        "location": "Remote",
        "salary": "$90,000 - $110,000",
        "type": "Full-time",
        "description": "Join our growing frontend team to build beautiful and responsive user interfaces using React and modern web technologies."
    },
    {
        "id": 3,
        "title": "DevOps Engineer",
        "company": "CloudTech Solutions",
        "location": "Austin, TX",
        "salary": "$100,000 - $130,000",
        "type": "Full-time",
        "description": "We need a DevOps engineer to help us scale our infrastructure and implement CI/CD pipelines using AWS and Docker."
    },
    {
        "id": 4,
        "title": "Data Scientist",
        "company": "Analytics Pro",
        "location": "Nrk, NY",
        "salary": "$110,000 - $140,000",
        "type": "Full-time",
        "description": "Looking for a data scientist to analyze large datasets and build machine learning models to drive business insights."
    },
    {
        "id": 5,
        "title": "UI/UX Designer",
        "company": "Design Studio",
        "location": "Los Angeles, CA",
        "salary": "$80,000 - $100,000",
        "type": "Contract",
        "description": "Creative UI/UX designer needed to design intuitive user experiences for our mobile and web applications."
    }
]

# Counter for generating new job IDs
next_job_id = 6

@app.route('/jobs', methods=['GET'])
def get_jobs():
    """Return a list of all jobs"""
    return jsonify(jobs)

@app.route('/jobs/<int:job_id>', methods=['GET'])
def get_job(job_id):
    """Return job details by ID"""
    job = next((job for job in jobs if job['id'] == job_id), None)
    if job is None:
        return jsonify({'error': 'Job not found'}), 404
    return jsonify(job)

@app.route('/jobs', methods=['POST'])
def create_job():
    """Add a new job"""
    global next_job_id
    
    data = request.get_json()
    
    # Validate required fields
    required_fields = ['title', 'company', 'location', 'salary', 'type', 'description']
    for field in required_fields:
        if field not in data:
            return jsonify({'error': f'Missing required field: {field}'}), 400
    
    # Create new job
    new_job = {
        'id': next_job_id,
        'title': data['title'],
        'company': data['company'],
        'location': data['location'],
        'salary': data['salary'],
        'type': data['type'],
        'description': data['description']
    }
    
    jobs.append(new_job)
    next_job_id += 1
    
    return jsonify(new_job), 201

@app.route('/jobs/<int:job_id>', methods=['DELETE'])
def delete_job(job_id):
    """Delete a job by ID"""
    global jobs
    
    job_index = next((i for i, job in enumerate(jobs) if job['id'] == job_id), None)
    if job_index is None:
        return jsonify({'error': 'Job not found'}), 404
    
    deleted_job = jobs.pop(job_index)
    return jsonify({'message': 'Job deleted successfully', 'job': deleted_job})

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'healthy', 'message': 'JobFinder Backend is running'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
