import sys
import subprocess
from flask import Flask, request, jsonify
import random
import string
import time

app = Flask(__name__)


def temp_pass():
    passd = ''.join(random.choices(string.ascii_letters + string.digits, k=10))
    subprocess.run(['./password.sh', passd])
    return passd

def expire():
     subprocess.run(['./expire.sh'])

def port():
    port = subprocess.run(['./port.sh'], capture_output=True, text=True)
    output = port.stdout
    no = port = output.strip()
    return no

def r_path():
    version = random.randint(1, 1000)
    return f'v{version}'

@app.route('/')
def unused_port():
    response = {
        "port": port()
    }

    return jsonify(response)
@app.route('/temp_passd')
def temp():
    response = {
        "passd": temp_pass()
    }

    return jsonify(response)

@app.route('/connection', methods=['GET', 'POST'])
def conn():
    return "connection"
    

@app.route('/tunnel/<parameters>', methods=['GET', 'POST'])
def tunnel(parameters):
    path = "api"+r_path()
    script = "./nginx.sh"
    port = parameters
    subprocess.run(["bash", script, port, str(path)])
    time.sleep(5)
    expire()  
    return path


if __name__ == '__main__':
    app.run(debug=True)
