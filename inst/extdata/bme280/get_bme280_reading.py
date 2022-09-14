
import smbus2
import bme280

port = 1
address = 0x77
bus = smbus2.SMBus(port)

calibration_params = bme280.load_calibration_params(bus, address)
    
data = bme280.sample(bus, address, calibration_params)

myData = [str(data.id), str(data.timestamp), str(data.temperature), str(data.pressure), str(data.humidity), "\n"]

delim = ","
    
myString = delim.join(myData)
    
myFile = open("/home/pi/Desktop/bme280/pi2_bme280_readings.txt", "a")
    
myFile.write(myString)
    
myFile.close()
