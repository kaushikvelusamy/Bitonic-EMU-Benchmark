# Tools
BIN_DIR ?= /usr/local/emu/bin

EMU_CC = $(BIN_DIR)/emu-cc
EMUSIM = $(BIN_DIR)/emusim.x
EMUPROF = $(BIN_DIR)/emusim_profile
GOBJD = $(BIN_DIR)/gossamer64-objdump
AR = $(BIN_DIR)/gossamer64-ar
RANLIB = $(BIN_DIR)/gossamer64-ranlib

EMUCFLAGS ?= $(CFLAGS)

default: $(EXE).mwx

run: $(EXE).mwx
	$(EMUSIM) $(SIMFLAGS) -- $< $(INPUTS)

profile: $(EXE).mwx
	$(EMUPROF) $(PROFDIR) $(SIMFLAGS) -- $< $(INPUTS)

clean:
	rm -f *.o *.mwx *.ll *.s *.sxp *.cdc *.vsf *.hdd

do%:
	$(MAKE) $(EXE).$*

%.mwx: %.c
	$(EMU_CC) $(EMUCFLAGS) -o $@ $^ $(EMULDFLAGS)

%.tqd: %.mwx
	$(EMUSIM) $(SIMFLAGS) --capture_timing_queues -o $* -- $< $(INPUTS)

%.uis: %.mwx
	$(EMUSIM) $(SIMFLAGS) --output_instruction_count -o $* -- $< $(INPUTS)

%.visa: %.mwx
	$(EMUSIM) $(SIMFLAGS) --verbose_isa -- $< $(INPUTS) > $@

%.st: %.mwx
	$(EMUSIM) $(SIMFLAGS) --untimed_short_trace -- $< $(INPUTS) > $@

%.od: %.mwx
	$(GOBJD) -Dx $< > $@

%.a:
	$(AR) -rv $@ $^
	$(RANLIB) $@
