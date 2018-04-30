.PHONY: all
.PHONY: clean

CC=emu-cc

DEBUG=0
SIMULATOR=0
HARDWARE=1

ifeq ($(SIMULATOR), 1)
  CFLAGS = -DSIMULATOR
endif
ifeq ($(HARDWARE), 1)
  CFLAGS += -DHARDWARE
endif
ifeq ($(DEBUG), 1)
  CFLAGS = -DDEBUG
endif

all: bitonic_EMU_iterative

bitonic_EMU_iterative: bitonic_EMU_iterative.c
	${CC} ${CFLAGS} bitonic_EMU_iterative.c -o ../../bin/bitonic_EMU_iterative.mwx

clean:
	rm -rf *.o *.mwx ../../bin/bitonic_EMU_iterative.mwx *.cdc *.vsf
