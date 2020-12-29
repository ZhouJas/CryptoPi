
import python.pn532.pn532 as nfc
import requests
import json
import NFCReader
import RPi.GPIO as GPIO
import time
import camera
import FaceDetection as face
import Adafruit_GPIO.SPI as SPI
import Adafruit_SSD1306
from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont

url = "" #SERVER URL
pictureUrl = ""

#block_number = 14
#key_a = b'\xFF\xFF\xFF\xFF\xFF\xFF'


def getTap(): #this function will loop
    reader, tag = NFCReader.readCard()
    
    #Take picture to verify
    displayText("Taking Picture", "")
    GPIO.cleanup()

    camera.takePicture()
    displayText("Picture Taken", "")

    #if no face, take picture again
    hasface = face.hasFace()
    while(hasface==False):
        displayText("Please have", "Face in Picture")
        camera.takePicture()
        hasface = face.hasFace()

    #Choose the amount to send through button presses
    money = getMoney()
    dic = {"tag": str(tag), "reader": str(reader), "money":money, "file": pictureUrl}
    print("sending: " + str(dic))
    strdic = json.dumps(dic)
    jsond=json.loads(strdic)
    response = requests.post(url, json=jsond)

    print("Status code: ", response.status_code)

def getMoney():
    print("")
    money= 0
    while True:
        displayText("Amount chosen:", str(float(money)/float(1000000000000000000)))
        GPIO.cleanup()
        but = getButton()
        if but == 1:
            money += 100000000000000000
            print("Current amount is " + str(money))
            displayText("Amount chosen:", str(float(money)/float(1000000000000000000)))
            GPIO.cleanup()
        elif but == 2:
            if(money-1000000000000000000>=0):
                money -= 1000000000000000000
                print("Current amount is "+  str(money))
                displayText("Amount chosen:", str(float(money)/float(1000000000000000000)))
                GPIO.cleanup()
            else:
                print("Not enough funds")
                displayText("Not enough funds", str(float(money)/float(1000000000000000000)))
                GPIO.cleanup()
            
        elif but == 3:
            print("")
            print("")
            print("Amount sent!")
            GPIO.cleanup()
            return money
            
def getButton(): 
    GPIO.setwarnings(False) #False = Ignore warnings
    GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
    GPIO.setup(10, GPIO.IN, pull_up_down=GPIO.PUD_DOWN) # Set pin 10 to be an input pin and set initial value to be pulled low (off)
    GPIO.setup(8, GPIO.IN, pull_up_down=GPIO.PUD_DOWN) # Set pin 8 to be an input pin and set initial value to be pulled low (off)
    GPIO.setup(12, GPIO.IN, pull_up_down=GPIO.PUD_DOWN) # Set pin 12 to be an input pin and set initial value to be pulled low (off)
    print("Please press a button")
    while True: # Run forever
        if GPIO.input(10) == GPIO.HIGH:
            time.sleep(.42)
            print("Button 1 was pushed!")
            GPIO.cleanup()
            return 1
        if GPIO.input(8) == GPIO.HIGH:
            time.sleep(.42)
            print("Button 2 was pushed!")
            GPIO.cleanup()
            return 2
        if GPIO.input(12) == GPIO.HIGH:
            time.sleep(.42)
            print("Button 3 was pushed!") 
            GPIO.cleanup()
            return 3   

def displayText(s1, s2):
    # Raspberry Pi pin configuration:
    RST = 24
    # Note the following are only used with SPI:
    DC = 23
    SPI_PORT = 0
    SPI_DEVICE = 0
    disp = Adafruit_SSD1306.SSD1306_128_32(rst=RST)

    # Create blank image for drawing.
    # Make sure to create image with mode '1' for 1-bit color.
    width = disp.width
    height = disp.height
    image = Image.new('1', (width, height))
    padding = 2
    shape_width = 20
    top = padding
    bottom = height-padding
    x = padding
    font = ImageFont.load_default()
    # Get drawing object to draw on image.
    draw = ImageDraw.Draw(image)
    # Initialize library.
    disp.begin()
    
    # Clear display.
    disp.clear()
    disp.display()

    draw.text((x, top),    s1,  font=font, fill=255)
    draw.text((x, top+20), s2, font=font, fill=255)
    disp.image(image)
    disp.display()

def clearDisplay():
    disp.begin()
    disp.clear()


def main():
    print("Now Running")
    print("")
    print("")
    displayText("This is", "CryptoPi")
    while True:
        getTap()

    print("Program Done")
    GPIO.cleanup()

if __name__ == "__main__":
    main()
