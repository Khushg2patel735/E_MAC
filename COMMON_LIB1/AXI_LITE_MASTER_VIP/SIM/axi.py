import os
os.system("vlib work")
os.system('vlog ../ENV/axi_env_pkg.sv ../TEST/axi_test_pkg.sv ../TOP/axi_tb_top.sv +incdir+../ENV/Master +incdir+../ENV/Slave +incdir+../ENV  +incdir+../TEST')
os.system('vopt axi_tb_top -o axi_tb_top_opt')
os.system('vsim axi_tb_top_opt -c -do "run -all;exit"')
#os.system('vcover report -html ram_report')
	