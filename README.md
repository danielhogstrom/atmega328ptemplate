# Atmega328p Template Project using Arduino as ISP

# Requirements
  ### AVR 8-Bit Toolchain (Linux)
    https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers
  ### AVRDUDE for Linux
    sudo apt-get install avrdude
# Commands using make
    make
    
    make flash
# Commands
  ### Compile for atmega328
    avr-gcc -Wall -Wextra -Os -DF_CPU=16000000UL -mmcu=atmega328p <c-file>  
  avr-gcc -Wall -Wextra -Os -DF_CPU=16000000UL -mmcu=atmega328p **main.c**

  ### Convert to .hex
    avr-objcopy -O ihex -R .eeprom <out-file> <hex-file>
  avr-objcopy -O ihex -R .eeprom **a.out** **firmware.hex**
  
  ### Upload to atmega328p using Arduino  
    avrdude -v -p atmega328p -c arduino -b 115200 -D -P <tty-port> -U flash:w:<hex-file>:i
  avrdude -v -p atmega328p -c arduino -b 115200 -D -P **/dev/ttyACM0** -U flash:w:**firmware.hex**:i
