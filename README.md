# flask-deployment-using-aws
# flask-deployment-using-aws

A production-ready Flask deployment project using AWS EC2, Gunicorn, and Nginx.

---Features

- Flask Web Application
- AWS EC2 Deployment
- Gunicorn WSGI Server
- Nginx Reverse Proxy
- Ubuntu Linux Server Setup
- Systemd Service Configuration
- GitHub Version Control
- Production Deployment Workflow

---

## 🛠 Technologies Used

- Python
- Flask
- AWS EC2
- Ubuntu
- Gunicorn
- Nginx
- Git & GitHub

---

## Project Structure

```bash
flask-deployment-using-aws/
│
├── app.py
├── requirements.txt
├── wsgi.py
├── README.md
├── .gitignore
│
├── templates/
│   └── index.html
│
├── static/
│   └── style.css
│
└── deployment/
    ├── gunicorn.service
    └── nginx.conf
