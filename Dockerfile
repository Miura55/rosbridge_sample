FROM ros:noetic

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=guest
ARG USER_UID=1000
ARG USER_GID=1000

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install rosbridge
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y ros-noetic-rosbridge-suite

# install python3 pip3
RUN apt update && apt install -y python3-pip

# install python3 dependencies
WORKDIR /catkin_ws/src
COPY ./requirements.txt /catkin_ws/src
RUN pip3 install -r requirements.txt

# Install ROS image packages
RUN apt install -y \
    libpcap-dev\
    ros-noetic-usb-cam\
    ros-noetic-image-view\
    ros-noetic-tf\
    ros-noetic-image-transport\
    ros-noetic-image-transport-plugins\
    ros-noetic-cv-bridge\
    ros-noetic-pcl-conversions\
    ros-noetic-pcl-ros\
    ros-noetic-controller-manager

# Copy ros packages
RUN mkdir -p /catkin_ws/src
COPY ./dummy_sensor /catkin_ws/src/dummy_sensor
COPY ./tf2_web_republisher /catkin_ws/src/tf2_web_republisher

# Build ros packages
SHELL ["/bin/bash", "-c"]
RUN apt install -y python3-catkin-tools libcpprest-dev && \
    cd /catkin_ws && \
    source /opt/ros/noetic/setup.bash && \
    rosdep update && \
    catkin init && \
    rosdep install -i --from-paths ./ && \
    catkin build && \
    source /catkin_ws/devel/setup.bash

# Install Node.js & yarn
RUN apt-get update && apt-get install -y curl && \
    curl -s https://deb.nodesource.com/setup_16.x | sudo bash && \
    apt-get update && apt-get install -y nodejs && \
    npm install -g yarn

USER $USERNAME
WORKDIR /home/$USERNAME
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN echo 'export QT_X11_NO_MITSHM=1' >> ~/.bashrc && \
    source ~/.bashrc

EXPOSE 9090
ENTRYPOINT [ "bash", "-c", "source /opt/ros/noetic/setup.bash && roslaunch rosbridge_server rosbridge_websocket.launch" ]
CMD [ "bash" ]
