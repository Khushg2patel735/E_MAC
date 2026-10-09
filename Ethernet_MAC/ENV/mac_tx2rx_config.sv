//======================================================================
// File Name      : mac_tx2rx_config.sv
// Module Name    : mac_tx2rx_config
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-17 15:39:35
// Last Modified  : 2026-09-08 18:37:38
// Language       : SystemVerilog
//
// Description    :
//
// Functionality  :
//
// Ports          :
//
// Notes          :
//
//======================================================================
`ifndef MAC_TX2RX_CONFIG
`define MAC_TX2RX_CONFIG
class mac_tx2rx_config extends uvm_object;

    function new(string name="");
        super.new(name);
    endfunction

    int no_of_mac_tx_agent;
    int no_of_axis_mas;
    int no_of_axi_lite_mas;

    uvm_active_passive_enum is_active = UVM_ACTIVE;

    `uvm_object_utils_begin(mac_tx2rx_config)
        `uvm_field_int(no_of_mac_tx_agent,UVM_ALL_ON)
        `uvm_field_int(no_of_axis_mas,UVM_ALL_ON)
        `uvm_field_int(no_of_axi_lite_mas,UVM_ALL_ON)
	    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON | UVM_STRING)
	   `uvm_object_utils_end

endclass

`endif

