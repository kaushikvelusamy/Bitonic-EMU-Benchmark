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

all: bitonic_EMU_recursive_old

bitonic_EMU_recursive_old: bitonic_EMU_recursive_old.c
	${CC} ${CFLAGS} bitonic_EMU_recursive_old.c -o ./bitonic_EMU_recursive_old.mwx

clean:
	rm -rf *.o *.mwx bitonic_EMU_recursive_old.mwx *.cdc *.vsf *.tqd
