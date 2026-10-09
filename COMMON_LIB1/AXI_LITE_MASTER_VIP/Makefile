SHELL=/bin/bash

#Variables:
FUSESOC_LIB_DIR = ../.fusesoc
ifndef SEED 
	RANDOM_SEED = $(shell echo $$RANDOM)
else
	RANDOM_SEED = $(SEED)
endif

ifndef TEST 
	UVM_TESTNAME = axil_base_test
else
	UVM_TESTNAME = $(TEST)
endif

BUILD_DIR = $(GIT)/t10_verification/axi_lite_vip_$(UVM_TESTNAME)_$(RANDOM_SEED)_build

clean:
	rm -rf $(BUILD_DIR)

axi_lite_vip_build: clean
	mkdir $(BUILD_DIR)


axi_lite_vip_runsim: axi_lite_vip_build
	cd $(BUILD_DIR); fusesoc --verbose --cores-root .. run --no-export --target=sim "celare:t10_verif:axi_lite_master_vip:1.0.0" --UVM_TESTNAME=$(UVM_TESTNAME) --UVM_SEED=$(RANDOM_SEED)

