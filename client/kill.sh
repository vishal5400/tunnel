sudo ps -aux | grep "ssh" | awk '{print $2}' | xargs sudo kill -9
