FROM ros:noetic

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=guest

RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt update && \
    apt install -y curl gcc wget git

RUN useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME

# Install Node.js & yarn
RUN apt-get update && apt-get install -y curl && \
    curl -s https://deb.nodesource.com/setup_16.x | sudo bash && \
    apt-get update && apt-get install -y nodejs && \
    npm install -g yarn

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
    libpcap-dev \
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

WORKDIR /home/$USERNAME
RUN echo "source /catkin_ws/devel/setup.bash" >> /home/$USERNAME/.bashrc

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
