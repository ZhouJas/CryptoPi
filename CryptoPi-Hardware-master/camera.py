from picamera import PiCamera
from time import sleep
from datetime import datetime as date

camera = PiCamera()
now = date.now()


def takePicture():
    print("Taking picture now")
    camera.start_preview()
    sleep(3)
    camera.capture('face.jpg')
    camera.stop_preview()
    print("Picture taken at " + now.strftime("%H:%M:%S"))
