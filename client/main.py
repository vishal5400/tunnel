import sys
import subprocess
import requests
import json
import signal
from dotenv import load_dotenv
import os

load_dotenv()

server = os.getenv("SERVER")
server_ip = os.getenv("SERVER_IP")
def signal_handler(sig, frame):
    print("Exiting...")
    subprocess.run(["bash", "./kill.sh"])
    sys.exit(0)

def port_no():
    r = requests.get(f'{server}/')
    response = r.text
    response_data = json.loads(response)
    port = response_data["port"]
    return port
def passwd():
    r = requests.get(f'{server}/temp_passd')
    response = r.text
    response_data = json.loads(response)
    passd = response_data["passd"]
    return passd

def tunnel():
    passd = passwd()
    port = port_no()
    local_port = sys.argv[1]
    script = "./tunnel.sh"
    subprocess.run(["bash", script, passd, port, local_port, server_ip])
    r = requests.post(f'{server}/tunnel/{port}')
    response = r.text
    return response

def main():
    print(f"Weblink: {server}/"+ tunnel())
    print("Press Ctrl+C to exit")
    while True:
        pass

#atexit.register(exit_handler)

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal_handler)
    main()
