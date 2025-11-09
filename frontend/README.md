# JobFinder Frontend

A modern React web application for browsing and posting job listings, built with React Router and Tailwind CSS.

## Features

- 🏠 **Home Page**: Browse all job listings with search functionality
- 🔍 **Search**: Filter jobs by title, company, or location
- 📄 **Job Details**: View detailed job information on separate pages
- ➕ **Post Jobs**: Add new job listings through a form
- 📱 **Responsive**: Mobile-friendly design with Tailwind CSS
- 🚀 **Modern UI**: Clean and minimal interface

## Tech Stack

- **React 18** - Frontend framework
- **React Router 6** - Client-side routing
- **Tailwind CSS** - Utility-first CSS framework
- **Fetch API** - HTTP requests to backend

## Project Structure

```
frontend/
├── src/
│   ├── components/
│   │   ├── JobCard.jsx      # Individual job card component
│   │   ├── JobDetail.jsx    # Job details page component
│   │   └── JobList.jsx      # Job listings with search
│   ├── pages/
│   │   ├── Home.jsx         # Main home page
│   │   └── PostJob.jsx      # Post new job form
│   ├── App.jsx              # Main app with routing
│   ├── index.js             # Entry point
│   └── index.css            # Tailwind CSS imports
├── package.json
├── tailwind.config.js
└── Dockerfile
```

## Getting Started

### Prerequisites

- Node.js 18+ 
- npm or yarn
- JobFinder Backend running on http://localhost:5000

### Local Development

1. **Install dependencies:**
   ```bash
   cd frontend
   npm install
   ```

2. **Start the development server:**
   ```bash
   npm start
   ```

3. **Open your browser:**
   Navigate to http://localhost:3000

### Docker

1. **Build the Docker image:**
   ```bash
   cd frontend
   docker build -t jobfinder-frontend .
   ```

2. **Run the container:**
   ```bash
   docker run -p 3000:3000 jobfinder-frontend
   ```

## API Integration

The frontend connects to the JobFinder Backend API:

- **GET** `/jobs` - Fetch all job listings
- **GET** `/jobs/:id` - Fetch job details by ID
- **POST** `/jobs` - Create new job listing

## Routes

- `/` - Home page with job listings
- `/job/:id` - Job details page
- `/post-job` - Post new job form

## Features in Detail

### Job Listings
- Responsive grid layout
- Real-time search filtering
- Loading states and error handling
- Empty state messages

### Job Details
- Full job information display
- Back navigation
- Apply and Save buttons (UI only)
- Error handling for missing jobs

### Post Job Form
- Complete form validation
- Success/error feedback
- Auto-redirect after successful submission
- Responsive form layout

## Styling

Built with Tailwind CSS for:
- Responsive design
- Modern UI components
- Consistent spacing and typography
- Hover effects and transitions
- Loading animations

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
