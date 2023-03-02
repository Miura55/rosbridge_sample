#!/usr/bin/python3
import random
import rospy
from rospy.exceptions import ROSInterruptException
from sensor_msgs.msg import Range


class SonarSensor:
    def __init__(self):
        rospy.init_node('rober', anonymous=True)
        rospy.on_shutdown(self.shutdown)
        self.pub = rospy.Publisher('sonar', Range, queue_size=10)
        rospy.Timer(rospy.Duration(0.5), self.timer_callback)
    
    def timer_callback(self, data):
        distance = random.randint(0, 100)
        rospy.loginfo("distance: %f", distance)
        sensor_data = Range()
        sensor_data.range = distance
        self.pub.publish(sensor_data)

    def shutdown(self):
        rospy.sleep(1)
        rospy.loginfo("Shutdown")


if __name__ == '__main__':
    try:
        SonarSensor()
        rospy.spin()
    except ROSInterruptException:
        pass
