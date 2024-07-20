# Compiler and assembler
CC = gcc
ASM = nasm

# Assembler flags
CFLAGS =
ASMFLAGS = -f elf64

# Source files
C_SRC = main.c
ASM_SRC = $(wildcard *.asm)

# Object files
ASM_OBJ = $(ASM_SRC:.asm=.o)

# Target executable
TARGET = main

# Default target
all: $(TARGET)

# Rule to build the target executable
$(TARGET): $(ASM_OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(C_SRC) $(ASM_OBJ)

# Rule to assemble ASM source files into object files
%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

# Clean up
clean:
	rm -f $(ASM_OBJ) $(TARGET)

# Phony targets
.PHONY: all clean

