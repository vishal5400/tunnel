#!/bin/bash
# Check apt pakage managers
install_with_apt() {
  sudo apt update
  sudo apt install -y nginx python3 python3-pip
}

# Check yum pakage manager
install_with_yum() {
  sudo yum update
  sudo yum install epel-release -y
  sudo yum install -y nginx python3 python3-pip
}

#Detect the package manager
install_software() {
  local software_name="$package"
  
  # Check if APT is available
  if command -v apt > /dev/null; then
    install_with_apt "$software_name"
  # Check if YUM is available
  elif command -v yum > /dev/null; then
    install_with_yum "$software_name"
  else
    echo "Package manager not-found. Cannot install software."
  fi
}
install_software "package_name"

cd server && pip3 install -r requirements.txt
sudo cp -r server ~/.tunnel

# Assign the server name from the argument
server_name="$1"
nginx_conf_dir="/etc/nginx/sites-available"
nginx_conf_file="${server_name}"
sudo rm -rf /etc/nginx/sites-enabled
sudo mkdir -p  /etc/nginx/location_block
# Create an Nginx site configuration file
cat <<EOF > "${nginx_conf_dir}/${nginx_conf_file}"
server {
    listen 80;
    server_name ${server_name};
    include /etc/nginx/location_block/tunnel; 
    }
}
EOF

# Create a symlink to enable the site
sudo ln -s "${nginx_conf_dir}/${nginx_conf_file}" "/etc/nginx/sites-enabled/"

# Reload Nginx to apply the new configuration
sudo systemctl restart nginx.service

cat <<EOF > "/etc/systemd/system/tunnel-app.service"
[Unit]
Description=Tunnel app
After=network.target

[Service]
User=root
WorkingDirectory=~/.tunnrl
ExecStart=python3 server.py

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable tunnel-app
sudo systemctl start tunnel-app

echo "Setup Done"
