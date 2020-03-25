# Tools
BIN_DIR = /usr/local/emu-20.01-hotfix/bin

EXE ?= Bitonic_EMU_smart
EMULDFLAGS = -lemu_c_utils

ifdef S
INPUTS += -s
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

PROFDIR = $(S)N$(N)P$(P)R$(R)C$(C)

Bitonic_EMU_smart.st: INPUTS += -p 4
profile: INPUTS += -p 2
profile: SIMFLAGS += --model_hw

OPTIONS = Linear RecLin Recurse Debug

bin/$(EXE)Debug.mwx: CFLAGS += -DDEBUG
bin/$(EXE)Recurse.mwx: CFLAGS += -DRECURSIVE
bin/$(EXE)RecLin.mwx: CFLAGS += -DRECURSIVE -DLINEAR

export

build: default

allbin: $(patsubst %, bin/$(EXE)%.mwx, $(OPTIONS))

allprof: INPUTS += -p 2
allprof: SIMFLAGS += --model_hw
allprof: $(patsubst %, $(S)N$(N)P$(P)R$(R)C$(C)%, $(OPTIONS))

$(S)N$(N)P$(P)R$(R)C$(C)%: bin/$(EXE)%.mwx
	$(EMUPROF) $@ $(SIMFLAGS) -- $< $(INPUTS)

bin/$(EXE)%.mwx: $(EXE).c
	$(MAKE) $(EXE).mwx
	mv -f $(EXE).mwx $@

include emucc.mk
