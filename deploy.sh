echo "Deploying Server"
current_directory=$(pwd)
read -p "Enter client url: " client_url

echo "Deploying Nginx"
cd Deployment
rm -f generated.conf
cat my_nginx.conf | sed -e "s@pwd@${current_directory}@g; s@client_url@${client_url}@g;" > generated.conf
sudo rm -f /etc/nginx/sites-enabled/default
sudo cp generated.conf /etc/nginx/sites-enabled

echo "Deploying Client"
cd ../Client
eval "ng build --base-href '/${client_url}/' --deploy-url '/${client_url}' --prod"
sudo service nginx restart
cd ../Server
uwsgi --http :8000 --module Server.wsgi &
