ARG VARIANT=3-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && \
    apt-get install -y less vim curl unzip sudo

# Install python modules
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install ROS dependencies
RUN pip install --extra-index-url https://rospypi.github.io/simple rospy-all && \
    pip install --extra-index-url https://rospypi.github.io/simple cv_bridge

# Install Node.js
ARG NODE_VERSION="16"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install Vite
RUN npm install -g vite
