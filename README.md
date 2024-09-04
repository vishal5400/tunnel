# Tunnel
This is a tunnel application made to expose your local development environment to the internet, similar to ngrok. It includes both server and client code. You can use this setup with your own server to expose your team's development applications to the internet for testing purposes.

In this repository, we include both the server and client code.

# Server Setup:
Run the server code on a publicly accessible server, such as any cloud provider's server. This server will handle incoming traffic and forward it to your local development environment.

# Client Setup:
Run the client code on your local machine. This code will establish a connection to the server and create a secure tunnel, making your local application accessible over the internet.

By using this setup, your team members can easily share their local development work with others for testing and collaboration.

# How to Set Up Your Own Server

To set up your own server, follow these steps:

1. Clone this repository:

    ```bash
    git clone https://github.com/vishal5400/tunnel.git
    ```

2. Navigate to the repository directory:

    ```bash
    cd yourrepository
    ```

3. Run the `server-setup.sh` script:

    ```bash
    ./server-setup.sh
    ```

    This script will automatically install all necessary dependencies and set up the server.

### Checking the Status of the Application

To check the status of the application, use the following command:

    
    systemctl status tunnel-app.service
    

# How to Install Client

Clone this repository and run the `client-setup.sh` script. It will automatically install all necessary dependencies and set up the server.

## Installation Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/vishal5400/tunnel.git
    ```
   cd your-repo
2. Run the setup script:
   ```bash
    ./client-setup.sh
    ```
3. Add your domain and server IP in .env file:

    Navigate to the `.client` directory and open the `.env` file using a text editor. Add the following variables and replace the placeholders with your domain and server IP:

```bash
    cd ~/.client
    vim .env
```
Add these variables in the .env file.:

    SERVER="http://your-domain.com"

    SERVER_IP="your-server-ip"

4. After installing the client, you can use it with the following command:
   ```bash
    tunnel-client <local-port>
    ```
