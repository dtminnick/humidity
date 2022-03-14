
import smbus2
import bme280
import time

port = 1

address = 0x77

bus = smbus2.SMBus(port)

calibration_params = bme280.load_calibration_params(bus, address)

# The sample method will take a single reading and return a
# compensated_reading object.

# The compensated_reading class has the following attributes

while True:
    
    data = bme280.sample(bus, address, calibration_params)
    
    did = str(data.id)
    time = str(data.timestamp)
    temp = str(data.temperature)
    pressure = str(data.pressure)
    humidity = str(data.humidity)

    reading = [did, time, temp, pressure, humidity, "\n"]

    delim = ","
    
    myString = delim.join(reading)
    
    myFile = open("bme280_readings.txt", "a")
    
    myFile.write(myString)
    
    myFile.close
    
    time.sleep(2)
