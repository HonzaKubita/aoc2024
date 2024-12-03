ifndef part
	all:
		@echo "Usage: make part=<number>"
    @echo "Compiles all .c files in the directory 'day<number>/part<number>'"
	$(error Please specify part=<number>)
endif

# Directories and files
DAY_DIR = day1/part$(part)/

# Ensure the directory exists
ifeq ("$(wildcard $(DAY_DIR))","")
  all:
		@echo "Directory does not exist"
	$(error Directory $(DAY_DIR) does not exist)
endif

# Find all .c files recursively in the specified day directory
C_FILES = $(shell find $(DAY_DIR) -type f -name "*.c")
# Corresponding object files
O_FILES = $(C_FILES:.c=.o)

# Output executable
EXEC = program

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -I$(DAY_DIR) # Include directory for header files

# Target to compile and link
$(EXEC): $(O_FILES)
	$(CC) $(CFLAGS) -o $@ $^

# Compile .c files into .o
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean target
.PHONY: all clean
clean:
	rm -f $(EXEC) $(O_FILES)
