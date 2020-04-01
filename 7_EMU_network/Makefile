# Tools
BIN_DIR ?= /usr/local/emu/bin

CC = $(BIN_DIR)/emu-cc
EMUSIM = $(BIN_DIR)/emusim.x
GOBJD = $(BIN_DIR)/gossamer64-objdump
AR = $(BIN_DIR)/gossamer64-ar
RANLIB = $(BIN_DIR)/gossamer64-ranlib

SIMFLAGS += --use_thread_ids

I ?= dataset16.dat
INPUTS = $(OPTS) $(I)

ifdef SIM
CFLAGS += -DSIM$(SIM)
endif

ifdef DEBUG
CFLAGS += -DDEBUG
endif

ifdef CYCLIC
CFLAGS += -DCYCLIC
endif

EXE ?= bitonic_network

all: $(EXE).mwx 

run_seq: bitonic_network_seq
	./$< $(INPUTS)

clean:
	rm -f *.o *.mwx *.ll *.s *.sxp *.cdc *.vsf *.hdd *.tqd $(EXE)_seq

run: $(EXE).mwx
	$(EMUSIM) $(SIMFLAGS) $< -- $(INPUTS)

%.mwx: %.c
	$(MAKE) -f $(firstword $(MAKEFILE_LIST)) $*
	mv -f $* $@

%.tqd: %.mwx
	$(EMUSIM) --capture_timing_queues -o $* $< $(INPUTS)

%.uis: %.mwx
	$(EMUSIM) --output_instruction_count -o $* $< $(INPUTS)

%.visa: %.mwx
	$(EMUSIM) --verbose_isa $< $(INPUTS) > $@

%.trace: %.mwx
	$(EMUSIM) --short_trace $< $(INPUTS) > $@

%.objdump: %.mwx
	$(GOBJD) -Dx $< > $@

%.a:
	$(AR) -rv $@ $^
	$(RANLIB) $@
