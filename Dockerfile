FROM ros:noetic

# Install rosbridge
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y ros-noetic-rosbridge-suite

# install python3 pip3
RUN apt update && apt install -y python3-pip

# install python3 dependencies
WORKDIR /catkin_ws/src
COPY ./requirements.txt /catkin_ws/src
RUN pip3 install -r requirements.txt

# copy ros package
RUN mkdir -p /catkin_ws/src
COPY ./dummy_sensor /catkin_ws/src/dummy_sensor
SHELL ["/bin/bash", "-c"]
RUN apt install -y python3-catkin-tools libcpprest-dev && \
    cd /catkin_ws && \
    source /opt/ros/noetic/setup.bash && \
    rosdep update && \
    catkin init && \
    rosdep install -i --from-paths ./ && \
    catkin build && \
    source /catkin_ws/devel/setup.bash

RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Install ROS image packages
RUN apt install -y ros-noetic-usb-cam ros-noetic-image-view

RUN echo 'export QT_X11_NO_MITSHM=1' >> ~/.bashrc && \
    source ~/.bashrc

EXPOSE 9090
ENTRYPOINT [ "bash", "-c", "source /opt/ros/noetic/setup.bash && roslaunch rosbridge_server rosbridge_websocket.launch" ]
