//======================================================================
// File Name      : mac_tx_mon.sv
// Module Name    : mac_tx_mon
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 00:00:28
// Last Modified  : 2026-08-16 03:13:39
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
`ifndef MAC_TX_MON_SV
`define MAC_TX_MON_SV

class mac_tx_mon extends uvm_monitor;

    `uvm_component_utils(mac_tx_mon)

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

endclass
`endif


