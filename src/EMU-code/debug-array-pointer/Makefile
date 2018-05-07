.PHONY: all
.PHONY: clean

CC=emu-cc

DEBUG=0
SIMULATOR=0
HARDWARE=1
POINTER=0

ifeq ($(POINTER), 1)
  CFLAGS = -DPOINTER
endif
ifeq ($(POINTER), 2)
  CFLAGS = -DPOINTER 
  CFLAGS += -DDEBUG
endif
ifeq ($(POINTER), 3)
  CFLAGS = -DPOINTER 
  CFLAGS += -DSIMULATOR
endif
ifeq ($(POINTER), 4)
  CFLAGS = -DPOINTER 
  CFLAGS += -DSIMULATOR
  CFLAGS += -DDEBUG
endif

ifeq ($(SIMULATOR), 1)
  CFLAGS = -DSIMULATOR
endif
ifeq ($(SIMULATOR), 2)
  CFLAGS = -DSIMULATOR
  CFLAGS += -DDEBUG
endif

ifeq ($(DEBUG), 1)
  CFLAGS = -DDEBUG
endif

ifeq ($(HARDWARE), 1)
  CFLAGS += -DHARDWARE
endif

all: bitonic_EMU_iterative

bitonic_EMU_iterative: bitonic_EMU_iterative.c
	${CC} ${CFLAGS} bitonic_EMU_iterative.c -o bitonic_EMU_iterative.mwx

clean:
	rm -rf *.o *.mwx *.part.tqd bitonic_EMU_iterative.mwx *.cdc *.vsf
