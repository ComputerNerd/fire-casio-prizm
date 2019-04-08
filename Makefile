CC=sh3eb-elf-gcc
CPP=sh3eb-elf-g++
OBJCOPY=sh3eb-elf-objcopy
MKG3A=mkg3a
RM=rm
CFLAGS=-m4a-nofpu -mb -fgcse-sm -fgcse-las -fgcse-after-reload -flto -Isrc -O2 -fmerge-all-constants -mhitachi -flto -Wall -Wextra -I../../include -lgcc -L../../lib -DCASIO_PRIZM -I../pSDL/include
LDFLAGS=$(CFLAGS) -nostartfiles -T../../toolchain/prizm.x -Wl,-static -Wl,-gc-sections -lgcc -flto -lSDL -L../pSDL
OBJECTS=fire.o
PROJ_NAME=fire
BIN=$(PROJ_NAME).bin
ELF=$(PROJ_NAME).elf
ADDIN=$(PROJ_NAME).g3a
 
all: $(ADDIN)
 
 
$(ADDIN): $(BIN)
	$(MKG3A) -n :fire $< $@
 
.s.o:
	$(CC) -c $(CFLAGS) $< -o $@
 
.c.o:
	$(CC) -c $(CFLAGS) $< -o $@
	
.cpp.o:
	$(CC) -c $(CFLAGS) $< -o $@
	
.cc.o:
	$(CC) -c $(CFLAGS) $< -o $@

$(ELF): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(BIN)

clean:
	$(RM) $(OBJECTS) $(BIN) $(ADDIN)
