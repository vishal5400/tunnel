port="$1"
api="$2"
nginx_conf="/etc/nginx/location_block/tunnel"
#port=$(echo "$port" | tr -d '\n')
conf_block="
	location /$api {
        	proxy_pass http://127.0.0.1:"$port";
    	}"

echo $conf_block
echo "$conf_block" | sudo tee -a $nginx_conf > /dev/null

sudo nginx -t
sudo nginx -s reload
