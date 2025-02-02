FROM python:3.10-slim-buster

# The dalai server runs on port 3000
EXPOSE 3000

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        curl \
        wget \
        net-tools \
        g++ \
	    git \
        make \
        python3-venv \
        software-properties-common

# Add NodeSource PPA to get Node.js 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# Install Node.js 18.x
RUN apt-get update \
    && apt-get install -y nodejs

WORKDIR /root/dalai
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
RUN tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin
# Install dalai and its dependencies
RUN npm install dalai@0.3.1

RUN npx dalai alpaca setup


# Run the dalai server
CMD [ "npx", "dalai", "serve" ]

