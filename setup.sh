curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nginx python-dev python3-dev redis-server nodejs virtualenv
virtualenv venv -p python3
source venv/bin/activate
pip install -r requirements.txt
npm install -g @angular/cli
django-admin startproject Server
ng new Client
sudo service nginx start
sudo service redis-server start
