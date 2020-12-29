from python.pn532 import *
import python.pn532.pn532 as nfc
import RPi.GPIO as GPIO


pn532 = PN532_SPI(cs=4, reset=20, debug=False)
pn532.SAM_configuration()

block_number = 16 #Data will be written to this block
key_a = b'\xFF\xFF\xFF\xFF\xFF\xFF'

def readCard():
    pn532 = PN532_SPI(cs=4, reset=20, debug=False)
    pn532.SAM_configuration()
    while True:
        # Check if a card is available to read
        uid = pn532.read_passive_target(timeout=0.5)
        print('.', end="")
        # Try again if no card is available.
        if uid is not None:
            break
    print('Found card with UID:', [hex(i) for i in uid])

    try:
        #This part is honestly just magic
        uid = pn532.read_passive_target(timeout=0.5)
        pn532.mifare_classic_authenticate_block(uid, block_number=block_number, key_number=nfc.MIFARE_CMD_AUTH_A, key=key_a)


        
        b = pn532.mifare_classic_read_block(block_number) #THE BYTE ARRAY / BLOCK
        #print([x for x in b])                                   <------- printed all elements in byte array
        GPIO.cleanup()
        return str(b[1]), 2
    except nfc.PN532Error as e:
        print(e.errmsg)
    GPIO.cleanup()

    