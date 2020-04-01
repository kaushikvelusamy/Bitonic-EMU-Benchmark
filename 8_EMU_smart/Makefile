# Tools
BIN_DIR ?= /usr/local/emu/bin

EMU_CC = $(BIN_DIR)/emu-cc
EMUSIM = $(BIN_DIR)/emusim.x
EMUPROF = $(BIN_DIR)/emusim_profile
GOBJD = $(BIN_DIR)/gossamer64-objdump
AR = $(BIN_DIR)/gossamer64-ar
RANLIB = $(BIN_DIR)/gossamer64-ranlib

EMUCFLAGS ?= $(CFLAGS)
EMULDFLAGS = -lemu_c_utils

EXE ?= BitonicSort


ifdef X
CFLAGS += -DRECURSIVE
endif

ifdef D
CFLAGS += -DDEBUG
endif

ifdef S
INPUTS += -s
endif

ifdef O
INPUTS += -p $(O)
endif

ifdef N
INPUTS += -n $(N)
endif

ifdef R
INPUTS += -R $(R)
endif

ifdef C
INPUTS += -C $(C)
endif

ifdef P
SIMFLAGS += -n $(P)
endif

PROFFLAG = 2;
PROFDIR = $(S)N$(N)P$(P)R$(R)C$(C)
SWEEPLOG = sweeps.log
JOBFILE = scripts/jobfile

BitonicSort.st: INPUTS += -p 10
profile: INPUTS += -p $(PROFFLAG)
profile: SIMFLAGS += --model_hw

OPTIONS = Linear RecLin Recurse Debug

bin/$(EXE)Debug.mwx: CFLAGS += -DDEBUG
bin/$(EXE)Recurse.mwx: CFLAGS += -DRECURSIVE
bin/$(EXE)RecLin.mwx: CFLAGS += -DRECURSIVE -DLINEAR

export

build: default

allbin: $(patsubst %, bin/$(EXE)%.mwx, $(OPTIONS))

allprof: $(patsubst %, $(S)N$(N)P$(P)R$(R)C$(C)%, $(OPTIONS))

sweeps: $(JOBFILE)
	nice nohup parallel -a $(JOBFILE) --joblog $(SWEEPLOG) &

$(S)N$(N)P$(P)R$(R)C$(C)%: bin/$(EXE)%.mwx
	$(EMUPROF) $@ --model_hw $(SIMFLAGS) -- $< -p $(PROFFLAG) $(INPUTS)

bin/$(EXE)%.mwx: $(EXE).c
	$(MAKE) $(EXE).mwx
	mv -f $(EXE).mwx $@

# below is my standard Makefile for all projects
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
