default: all

# Compiler
CC = avr-gcc

# Compiler flags
CFLAGS = -Wall -Wextra -Os -DF_CPU=16000000UL -mmcu=atmega328p

# Command to convert ELF to HEX
HEX = avr-objcopy -O ihex -R .eeprom

# Source files
SRCS = main.c

# Build directory
BUILD_DIR = build

# Object files (derived from source files)
OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o)

# Target executable
TARGET = $(BUILD_DIR)/program

###########################################################
# Build
###########################################################
# Create the build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build the target executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(TARGET)

# Rule to build object files from source files
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule to generate the HEX file from the target executable
$(BUILD_DIR)/program.hex: $(TARGET)
	$(HEX) $(TARGET) $@

###########################################################
# Phony targets
###########################################################
.PHONY: flash all clean

# Build all
all: $(BUILD_DIR)/program.hex

# Flash the HEX file to the microcontroller
flash: $(BUILD_DIR)/program.hex
	avrdude -v -p atmega328p -c arduino -b 115200 -D -P /dev/ttyACM0 -U flash:w:$<:i

# Clean the build files
clean:
	rm -rf $(BUILD_DIR)

