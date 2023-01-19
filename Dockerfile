FROM ros:melodic

# Install rosbridge
RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y ros-melodic-rosbridge-suite

# install python3 pip3
RUN apt update && apt install -y python3-pip && \
    ln /usr/bin/pip3 /usr/bin/pip

# install python3 dependencies
WORKDIR /catkin_ws/src
COPY ./requirements.txt /catkin_ws/src
RUN pip3 install -r requirements.txt

# copy ros package
RUN mkdir -p /catkin_ws/src
COPY ./dummy_sensor /catkin_ws/src/dummy_sensor
SHELL ["/bin/bash", "-c"]
RUN apt install -y python-catkin-tools libcpprest-dev && \
    cd /catkin_ws && \
    source /opt/ros/melodic/setup.bash && \
    rosdep update && \
    catkin init && \
    rosdep install -i --from-paths ./ && \
    catkin build && \
    source /catkin_ws/devel/setup.bash

RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

EXPOSE 9090
CMD [ "bash", "-c", "source /opt/ros/melodic/setup.bash && roslaunch rosbridge_server rosbridge_websocket.launch" ]
