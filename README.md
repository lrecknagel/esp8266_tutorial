# Usage of esp8266

## Component Overview
![Components](../../blob/master/readme_files/comp_overview.png?raw=true)

* A -> Dallas DS18B20 temperature sensor
* B -> ESP8266 WIFI module
* C -> CP2102 Breakout Board
(http://www.amazon.de/USB-TTL-Konverter-Modul-mit-eingebautem-CP2102/dp/B008RF73CS?ie=UTF8&psc=1&redirect=true&ref_=oh_aui_detailpage_o07_s00)

## How to flash ESP8266

* Connect the pins of B as follows:
  * B_VCC   -> + (VCC)
  * B_GND   -> - (GND)
  * B_TX    -> C_RXI
  * B_RX    -> C_TXO
  * B_GPIO0 -> - (GND)
  * B_CH_PD -> + (VCC)
  * C_GND   -> - (GND)

* Driver: for board C use the following driver:
  * https://www.silabs.com/products/mcu/Pages/USBtoUARTBridgeVCPDrivers.aspx

* Flashing-Tool: esptool
  * https://github.com/themadinventor/esptool
  * clone && install
  * download image of nodeMCU (or what ever you want) (https://github.com/nodemcu/nodemcu-firmware/releases)
  * open terminal and run:
  ```
  ./esptool.py --port /dev/tty.SLAB_USBtoUART write_flash 0x0000 img_file_name.bin
  ```
  * wait until flashed:
    * something like: ```Wrote 462848 bytes at 0x00000000 in 44.9 seconds (82.5 kbit/s)...```

* Issues:
  * if esptool.py tell about an error:
    * remove B_CH_PD pin from + (VCC) and reinsert the pin
    * restart the script
  * if you are using a different USB2UART the TX / RX pins are maybe not flipped

## How to transfer LUA scripts

  * Download ESPlorer: https://github.com/4refr0nt/ESPlorer (http://esp8266.ru/esplorer/#download)
  * Open and connect on USBtoUART Port with 9600 Baud
  * You should see something that init.lua could not be loaded if not:
    * remove B_CH_PD pin from + (VCC) and reinsert the pin
  * No in the bottom left of the app click the button: *Upload...*
  * Select your init.lua and more if you have more ;)

## Ho to connect DS18B20

  * B_VCC   -> + (VCC)
  * B_ GND  -> - (GND)
  * B_CH_PD -> + (VCC)
  * B_GPIO2 -> A_GPIO2
  * A_GND   -> - (GND)
  * A_VCC   -> + (VCC)

  * Info:
    * If you are using GPIO0 instead of GPIO2 on ESP8266 you have to change ds.lua in line 3

## MISC

* If any of the tools are no longer available, you can hopefully download a copy (maybe old) here:
  * https://dl.dropboxusercontent.com/u/13285300/esp8266_tools.zip

* Further reading:
  * https://github.com/nodemcu/nodemcu-firmware
