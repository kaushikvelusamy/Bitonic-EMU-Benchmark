.PHONY: all
.PHONY: clean

CC=emu-cc
DEBUG=0
TIMING=1

ifeq ($(DEBUG), 1)
  CFLAGS += -DDEBUG
endif
ifeq ($(TIMING), 1)
  CFLAGS += -DTIMING
endif

all: bitonic_EMU_iterative bitonic_EMU_recursive

bitonic_EMU_iterative: bitonic_EMU_iterative.c
	${CC} ${CFLAGS} bitonic_EMU_iterative.c -o bitonic_EMU_iterative.mwx

bitonic_EMU_recursive: bitonic_EMU_recursive.c
	${CC} ${CFLAGS} bitonic_EMU_recursive.c -o bitonic_EMU_recursive.mwx
	
clean:
	rm -rf *.o bitonic_EMU_iterative.mwx bitonic_EMU_recursive.mwx *.cdc *.vsf
