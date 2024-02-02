TARGET = main
LDFLAGS = -lSystem -lc -e main -arch arm64 -syslibroot `xcrun -sdk macosx --show-sdk-path`

BUILD_DIR = build
SRC_DIR = .

SRCS := $(shell find $(SRC_DIR) -name 'main.s')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

$(BUILD_DIR)/$(TARGET): $(OBJS)
	ld -o $@ $(LDFLAGS) $(OBJS)

$(BUILD_DIR)/%.o: $(SRCS)
	mkdir -p $(dir $@)
	as -arch arm64 $< -o $@

.PHONY: run clean

run: $(BUILD_DIR)/$(TARGET)
	$(BUILD_DIR)/$(TARGET)

clean:
	rm -r $(BUILD_DIR)
