# Tools
BIN_DIR ?= /usr/local/emu/bin

CC = $(BIN_DIR)/emu-cc
EMUSIM = $(BIN_DIR)/emusim.x
GOBJD = $(BIN_DIR)/gossamer64-objdump
AR = $(BIN_DIR)/gossamer64-ar
RANLIB = $(BIN_DIR)/gossamer64-ranlib

SIMFLAGS += --use_thread_ids

I ?= $(HOME)/external/Bitonic-EMU-Benchmark/dataset/min-old/paper8
INPUTS = $(OPTS) $(I)

ifdef SIM
CFLAGS += -DSIM$(SIM)
endif

EXE ?= bitonic_network

all: $(EXE).mwx

run_seq: bitonic_network_seq
	./$< $(INPUTS)

bitonic_network_seq: bitonic_network_seq.c
	gcc -std=c99 -o $@ $<

clean:
	rm -f *.o *.mwx *.ll *.s *.sxp *.cdc *.vsf *.hdd

seq:
	gcc -std=c99 -DSEQ=1 $(CFLAGS) $(EXE).c

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
