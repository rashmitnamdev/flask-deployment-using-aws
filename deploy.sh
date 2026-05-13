#!/bin/bash
# deploy.sh — Automates Flask deployment setup on Ubuntu EC2
# Usage: bash deploy.sh

set -e

REPO_URL="https://github.com/rashmitnamdev/flask-deployment-using-aws.git"
APP_DIR="/home/ubuntu/flask-deployment-using-aws"
SERVICE_NAME="flaskapp"

echo "===== [1/7] Updating system packages ====="
sudo apt update && sudo apt upgrade -y

echo "===== [2/7] Installing dependencies ====="
sudo apt install -y python3-pip python3-dev build-essential \
    libssl-dev libffi-dev python3-setuptools python3-venv nginx git

echo "===== [3/7] Cloning repository ====="
if [ -d "$APP_DIR" ]; then
    echo "Directory already exists. Pulling latest changes..."
    cd "$APP_DIR" && git pull
else
    git clone "$REPO_URL" "$APP_DIR"
    cd "$APP_DIR"
fi

echo "===== [4/7] Setting up Python virtual environment ====="
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo "===== [5/7] Setting up Gunicorn systemd service ====="
sudo cp flaskapp.service /etc/systemd/system/flaskapp.service
sudo systemctl daemon-reload
sudo systemctl start "$SERVICE_NAME"
sudo systemctl enable "$SERVICE_NAME"
echo "Gunicorn status:"
sudo systemctl status "$SERVICE_NAME" --no-pager

echo "===== [6/7] Configuring Nginx ====="
sudo cp nginx.conf /etc/nginx/sites-available/flaskapp
sudo ln -sf /etc/nginx/sites-available/flaskapp /etc/nginx/sites-enabled/flaskapp
sudo nginx -t && sudo systemctl restart nginx

echo "===== [7/7] Configuring firewall ====="
sudo ufw allow 'Nginx Full'
sudo ufw allow OpenSSH
sudo ufw --force enable

echo ""
echo "✅ Deployment complete! Visit: http://$(curl -s ifconfig.me)"
echo ""
echo "Next steps:"
echo "  1. Point your domain DNS A record to: $(curl -s ifconfig.me)"
echo "  2. Update nginx.conf with your domain name"
echo "  3. Run: sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com"
