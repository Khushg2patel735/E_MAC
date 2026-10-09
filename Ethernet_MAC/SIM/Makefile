comp:
	vlog -sv +acc -mfcu \
	+incdir+../../COMMON_LIB1 +incdir+../../COMMON_LIB1/AXI_STREAM_VIP \
	+incdir+../../COMMON_LIB1 +incdir+../../COMMON_LIB1/AXI_LITE_UPDATED_VIP \
	+incdir+../../COMMON_LIB1/AXI_STREAM_VIP/ENV \
	+incdir+../../COMMON_LIB1/AXI_STREAM_VIP/ENV/MASTER_AGENT \
	+incdir+../../COMMON_LIB1/AXI_STREAM_VIP/ENV/SLAVE_AGENT \
	+incdir+../../COMMON_LIB1/AXI_STREAM_VIP/TEST \
	+incdir+../../COMMON_LIB1/AXI_STREAM_VIP/TOP \
	+incdir+../ENV \
	+incdir+../ENV/MAC_TX_AGENT \
	+incdir+../ENV/MAC_RX_AGENT \
	+incdir+../ENV/RAL_REG \
	+incdir+../ENV/MAC_INF \
	+incdir+../RTL \
	+incdir+../RTL/Interface \
	+incdir+../TEST \
	+incdir+../TEST/SEQS \
	+incdir+../TEST/VSEQS \
	+incdir+../TEST/TESTS \
	+incdir+../TOP \
	../RTL/Interface/axi_lite_inf.sv \
	../RTL/Interface/axi_str_master_inf.sv \
	../RTL/Interface/axi_str_slave_inf.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/ENV/MASTER_AGENT/axi_str_mas_inf.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/ENV/SLAVE_AGENT/axi_str_slv_inf.sv \
	../../COMMON_LIB1/AXI_LITE_UPDATED_VIP/axi_lite_mas_interface.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/ENV/MASTER_AGENT/axi_str_mas_pkg.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/ENV/SLAVE_AGENT/axi_str_slv_pkg.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/ENV/axi_str_env_pkg.sv \
	../../COMMON_LIB1/AXI_STREAM_VIP/TEST/axi_str_pkg.sv \
	../../COMMON_LIB1/AXI_LITE_UPDATED_VIP/axi_lite_pkg.sv \
	../ENV/MAC_TX_AGENT/mac_tx_pkg.sv \
	../ENV/RAL_REG/mac_ral_reg_pkg.sv \
	../ENV/mac_env_pkg.sv \
	../RTL/e_mac_tx2_rx_top.sv \
	../TEST/mac_test_pkg.sv \
	../TOP/mac_tb_top.sv

sim: comp
	vsim -voptargs=+acc mac_tb_top -c -do "run -all; quit" -l emac.log

sim_gui: comp
	vsim -voptargs=+acc mac_tb_top -do "do wave.do; run -all"
