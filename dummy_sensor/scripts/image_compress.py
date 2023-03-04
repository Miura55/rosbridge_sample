#!/usr/bin/python3
import rospy
from rospy.exceptions import ROSInterruptException
from sensor_msgs.msg import CompressedImage, Image
import numpy as np
import cv2
from cv_bridge import CvBridge

class ImageRepublisher:
    def __init__(self):
        rospy.init_node('republisher', anonymous=True)
        rospy.on_shutdown(self.shutdown)
        self.bridge = CvBridge()
        self.pub = rospy.Publisher('camera/compressed', CompressedImage, queue_size=10)
        self.sub = rospy.Subscriber('image_raw', Image, self.republish_image)
        rospy.loginfo('Node started')

    def republish_image(self, data):
        raw_msg = self.bridge.imgmsg_to_cv2(data, 'bgr8')
        _, img =  cv2.imencode('.jpg', raw_msg, [int(cv2.IMWRITE_JPEG_QUALITY), 100])
       # Publish image
        msg = CompressedImage()
        msg.header.stamp = data.header.stamp
        msg.format = "jpeg"
        msg.data = np.array(img).tostring()
        self.pub.publish(msg)

    def shutdown(self):
        rospy.sleep(1)
        rospy.loginfo("Shutdown")


if __name__ == '__main__':
    try:
        ImageRepublisher()
        rospy.spin()
    except ROSInterruptException:
        pass
