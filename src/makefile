CC=i686-elf-gcc
CFLAGS= -Wall -g -O0
LDFLAGS=-ffreestanding -nostdlib -g -T link.ld -lgcc

OUT_DIR = ../bin
EXECUTABLE=../isodir/kernel.elf

SOURCES_C=$(wildcard *.c)
SOURCES_S=$(wildcard *.s)

OBJECTS_C=${OUT_DIR}/$(SOURCES_C:.c=.o)
OBJECTS_S=${OUT_DIR}/$(SOURCES_S:.s=.o)


.PHONY: all


all: $(OBJECTS_C) $(OBJECTS_S)  $(EXECUTABLE)


$(OBJECTS_C): $(SOURCES_C) 
	$(CC) $(CFLAGS)   -c -o $@ $<


$(OBJECTS_S): $(SOURCES_S) 
	$(CC)  -c -o $@ $<


$(EXECUTABLE): $(SOURCES_S)  $(SOURCES_C) 
	$(CC) $(LDFLAGS) $(OBJECTS_S) $(OBJECTS_C) -o $@