ARGS ?=
MODE ?= dev

CC := gcc-14
MKDIR_P := mkdir -p
RM_RF := rm -rf

TARGET := ark
LIBS :=
LDLIBS := $(addprefix -l,$(LIBS))
LDFLAGS :=

STANDARD := -std=c23
CFLAGS_dev := $(STANDARD) -Og -g3 -Wall -Wextra -Wpedantic -Werror -fsanitize=address,undefined \
			  -Wcast-qual -Wconversion -Wdouble-promotion -Wfloat-equal \
			  -Wformat -Wshadow -Wswitch-default -Wswitch-enum -Wundef
CFLAGS_debug := $(STANDARD) -O0 -g3
CFLAGS_release := $(STANDARD) -O3 -DNDEBUG
CFLAGS := $(CFLAGS_$(MODE))

BUILD_DIR := build
TARGET_DIR := $(BUILD_DIR)/$(MODE)
SRC_DIR := src

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(TARGET_DIR)/%.o)
DEPS := $(OBJS:.o=.d)
-include $(DEPS)
CPPFLAGS := -MMD -MP

.DELETE_ON_ERROR:
.PHONY: all run clean

all: $(TARGET_DIR)/$(TARGET)

$(TARGET_DIR)/$(TARGET): $(OBJS)
	@$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c | $(TARGET_DIR)
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(TARGET_DIR):
	$(MKDIR_P) $@

run: $(TARGET_DIR)/$(TARGET)
	@$< $(ARGS)

clean:
	@$(RM_RF) $(BUILD_DIR)
