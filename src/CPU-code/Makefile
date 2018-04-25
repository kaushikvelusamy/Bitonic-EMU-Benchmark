.PHONY: all
.PHONY: clean

CC=icc
CFLAGS=-std=c99 -I${HOME}/papi/include
LDFLAGS=-lpapi
DEBUG=0
TIMING=1

ifeq ($(DEBUG), 1)
  CFLAGS += -DDEBUG -ggdb
endif
ifeq ($(TIMING), 1)
  CFLAGS += -DTIMING
endif

all: bitonic_CPU_iterative bitonic_CPU_recursive

.c.o:
	${CC} ${CFLAGS} -c -o $@ $<

bitonic_CPU_iterative: bitonic_CPU_iterative.o
	${CC} ${CFLAGS} bitonic_CPU_iterative.o -o bitonic_CPU_iterative ${LDFLAGS}

bitonic_CPU_recursive: bitonic_CPU_recursive.o
	${CC} ${CFLAGS} bitonic_CPU_recursive.o -o bitonic_CPU_recursive ${LDFLAGS}
	
clean:
	rm -rf *.o bitonic_CPU_iterative bitonic_CPU_recursive
