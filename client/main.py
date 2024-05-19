import sys
import subprocess
import requests
import json
import signal

def signal_handler(sig, frame):
    print("Exiting...")
    subprocess.run(["bash", "./kill.sh"])
    sys.exit(0)

def port_no():
    r = requests.get('http://localhost:5000/')
    response = r.text
    response_data = json.loads(response)
    port = response_data["port"]
    return port
def passwd():
    r = requests.get('http://localhost:5000/temp_passd')
    response = r.text
    response_data = json.loads(response)
    passd = response_data["passd"]
    return passd

def tunnel():
    passd = passwd()
    port = port_no()
    local_port = sys.argv[1]
    script = "./tunnel.sh"
    subprocess.run(["bash", script, passd, port, local_port])
    r = requests.post(f'http://localhost:5000/tunnel/{port}')
    response = r.text
    return response

def main():
    print("Weblink: http://localhost/"+ tunnel())
    print("Press Ctrl+C to exit")
    while True:
        pass

#atexit.register(exit_handler)

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal_handler)
    main()
