### Verion 1: Separate Service Deployment

This repository contains a simple full-stack application composed of a Python API backend and a static HTML/CSS/JavaScript frontend. It is designed to be deployed on Render as two distinct services. This architecture is ideal for projects that require a clear separation of concerns, with the frontend and backend managed independently.

#### Services

*   **Python Web Service**: The api/ directory contains a Flask application that serves as the backend API.
    
*   **Static Site**: The ui/ directory contains the frontend files, including index.html and styles.css.
    

#### Deployment

This project can be deployed to Render by creating two separate services:

1.  A **Web Service** for the api/ directory, which will automatically run the Python backend.
    
2.  A **Static Site** for the ui/ directory, which will serve the frontend files.
    

#### CI/CD & DevSecOps

This project uses an automated CI/CD pipeline, managed by GitHub Actions, to ensure code quality and security on every push.

*   **Continuous Integration (CI)**: The pipeline automatically checks out the code and runs security analysis to ensure the application is secure before it is deployed.
    
*   **Continuous Deployment (CD)**: A deployment to Render is automatically triggered when changes are merged to the main branch.
    

**DevSecOps Practices:**

*   **Static Code Analysis**: The pipeline uses **Bandit** to scan the Python code for common security vulnerabilities.
    
*   **Vulnerability Scanning**: The pipeline uses **Trivy** to scan the base container images and dependencies for known vulnerabilities, ensuring the deployed service is secure from the ground up.
    

### Version 2: Single Container Deployment

This repository contains a full-stack application that is deployed as a single, self-contained Docker container. This project combines a Python API backend with a static HTML/CSS/JavaScript frontend using NGINX. The entire application is built and run from a single Dockerfile, simplifying the deployment process.

#### Project Structure

*   **api/**: Contains the Python Flask application and its dependencies.
    
*   **ui/**: Contains the static frontend files (index.html, styles.css).
    
*   **nginx/**: Contains the NGINX configuration (nginx.conf) to serve the static files and proxy requests to the Flask backend.
    
*   **Dockerfile**: Defines the single container, which includes Python, Flask, and NGINX.
    

#### Deployment

The application is built and run using the Dockerfile in the root of the repository. The CMD instruction is configured to start both the Python backend and the NGINX web server simultaneously. The render.yaml file defines this as a single Web Service.

To deploy this project, simply connect your repository to Render, which will use the provided Dockerfile to build and deploy your application.

#### CI/CD & DevSecOps

This project's CI/CD pipeline is designed to automate the entire build, test, and deployment process, with security checks integrated directly into the workflow.

*   **Continuous Integration (CI)**: The GitHub Actions pipeline automatically builds the Docker image and runs a series of tests to validate the application.
    
*   **Continuous Deployment (CD)**: A successful pipeline run on the main branch automatically triggers a deployment to Render.
    

**DevSecOps Practices:**

*   **Static Code Analysis**: **Bandit** is run inside the container to scan the application's Python code for security issues, shifting security left into the build phase.
    
*   **Vulnerability Scanning**: **Trivy** is used to scan the final Docker image for known vulnerabilities in OS packages and application dependencies.
    
*   **Secure Secrets Management**: The deployment hook URL is stored as a GitHub Secret, preventing sensitive information from being exposed in the ci.yaml file.
