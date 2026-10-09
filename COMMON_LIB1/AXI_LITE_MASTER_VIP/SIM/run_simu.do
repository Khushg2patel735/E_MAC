#set TC_NAME "F0_TC_SPI_${1}"
#set TRANSCRIPT_FILE "transcript_$TC_NAME.txt"

vlib work
vlog ../ENV/MASTER_AGENT/axil_master_pkg.sv  ../ENV/axil_env_pkg.sv ../TEST/axil_test_pkg.sv ../TOP/axil_tb_top.sv +incdir+../ENV/MASTER_AGENT +incdir+../ENV/Slave +incdir+../ENV  +incdir+../TEST
#vopt axil_tb_top -o axi_tb_top_opt 
#vsim axil_tb_top_opt
vsim -voptargs=+acc axil_tb_top +UVM_TESTNAME=${1} +UVM_VERBOSITY=UVM_DEBUG +UVM_CONFIG_DB_TRACE -sv_seed ${2}
#vsim spi_top_opt +UVM_TESTNAME=$TC_NAME -logfile $TRANSCRIPT_FILE -sv_seed {$random}

log -r /axil_tb_top/axil_master_vif/*
#log -r /axi_tb_top/axi_slave_vif/*


run 0ns
do wave.do
run -all

