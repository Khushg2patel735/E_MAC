onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axil_tb_top/axil_master_vif/ARESETn
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/drv_cb_event
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awsize
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awlen
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awburst
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/awaddr
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wlast
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wdata
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/wstrb
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/bvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/bready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/bid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/bresp
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rdata
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rlast
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} -group sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 /axil_tb_top/axil_master_vif/drv_cb/rresp
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arsize
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arlen
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arburst
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/arid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/drv_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/drv_cb} /axil_tb_top/axil_master_vif/drv_cb/araddr
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} /axil_tb_top/axil_master_vif/mon_cb/mon_cb_event
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awsize
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awlen
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awburst
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/awaddr
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wdata
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wstrb
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/wlast
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/bvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/bready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/bid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/bresp
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rdata
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rlast
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/rresp
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arvalid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arready
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arsize
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arid
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arlen
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/arburst
add wave -noupdate -label sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 -group {Region: sim:/axil_tb_top/axil_master_vif/mon_cb} -expand -group sim:/axil_tb_top/axil_master_vif/mon_cb/Group1 /axil_tb_top/axil_master_vif/mon_cb/araddr
add wave -noupdate /axil_tb_top/axil_master_vif/aclk
add wave -noupdate /axil_tb_top/axil_master_vif/ARESETn
add wave -noupdate /axil_tb_top/axil_master_vif/awid
add wave -noupdate /axil_tb_top/axil_master_vif/awaddr
add wave -noupdate /axil_tb_top/axil_master_vif/awlen
add wave -noupdate /axil_tb_top/axil_master_vif/awsize
add wave -noupdate /axil_tb_top/axil_master_vif/awburst
add wave -noupdate /axil_tb_top/axil_master_vif/awvalid
add wave -noupdate /axil_tb_top/axil_master_vif/awready
add wave -noupdate /axil_tb_top/axil_master_vif/wid
add wave -noupdate /axil_tb_top/axil_master_vif/wdata
add wave -noupdate /axil_tb_top/axil_master_vif/wstrb
add wave -noupdate /axil_tb_top/axil_master_vif/wlast
add wave -noupdate /axil_tb_top/axil_master_vif/wvalid
add wave -noupdate /axil_tb_top/axil_master_vif/wready
add wave -noupdate /axil_tb_top/axil_master_vif/bid
add wave -noupdate /axil_tb_top/axil_master_vif/bresp
add wave -noupdate /axil_tb_top/axil_master_vif/bvalid
add wave -noupdate /axil_tb_top/axil_master_vif/bready
add wave -noupdate /axil_tb_top/axil_master_vif/arid
add wave -noupdate /axil_tb_top/axil_master_vif/araddr
add wave -noupdate /axil_tb_top/axil_master_vif/arlen
add wave -noupdate /axil_tb_top/axil_master_vif/arsize
add wave -noupdate /axil_tb_top/axil_master_vif/arburst
add wave -noupdate /axil_tb_top/axil_master_vif/arvalid
add wave -noupdate /axil_tb_top/axil_master_vif/arready
add wave -noupdate /axil_tb_top/axil_master_vif/rid
add wave -noupdate /axil_tb_top/axil_master_vif/rdata
add wave -noupdate /axil_tb_top/axil_master_vif/rresp
add wave -noupdate /axil_tb_top/axil_master_vif/rlast
add wave -noupdate /axil_tb_top/axil_master_vif/rvalid
add wave -noupdate /axil_tb_top/axil_master_vif/rready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {1014 ns} 1} {{Cursor 2} {28660580 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 186
configure wave -valuecolwidth 74
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 1
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {800 ns}
