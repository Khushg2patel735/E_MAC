//======================================================================
// File Name      : mac_tx_config.sv
// Module Name    : mac_tx_config
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-17 15:04:10
// Last Modified  : 2026-08-17 15:38:28
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
`ifndef MAC_TX_CONFIG
`define MAC_TX_CONFIG
class mac_tx_config extends uvm_object;

    function new(string name="");
        super.new(name);
    endfunction

    int no_of_mac_tx_agent;

    `uvm_object_utils_begin(mac_tx_config)
        `uvm_field_int(no_of_mac_tx_agent,UVM_ALL_ON)
    `uvm_object_utils_end

endclass

`endif
