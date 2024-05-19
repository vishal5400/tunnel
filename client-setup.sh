#!/bin/bash
pip3 install -r client/requirements.txt
cp -r client ~/.client
cat <<EOF > "tunnel-client"
#!/bin/bash
arg="\$1"
python3 $HOME/.client/main.py "\$arg"
EOF
sudo mv tunnel-client /usr/local/bin/
sudo chmod +x /usr/local/bin/tunnel-client
