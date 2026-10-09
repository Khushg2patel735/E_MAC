#makefile

comp:
	vlog ../ENV/MASTER_AGENT/axil_master_pkg.sv  ../ENV/axil_env_pkg.sv ../TEST/axil_test_pkg.sv ../TOP/axil_tb_top.sv +incdir+../ENV/MASTER_AGENT +incdir+../ENV/Slave +incdir+../ENV  +incdir+../TEST

sim:
	vsim -voptargs=+acc axil_tb_top -c -do "run -all; exit"

wave:
	vsim -voptargs=+acc axil_tb_top -do "do wave.do; run -all; exit"
