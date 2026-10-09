//======================================================================
// File Name      : mac_tx_base_seqs.sv
// Module Name    : mac_tx_base_seqs
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-18 15:09:52
// Last Modified  : 2026-08-22 22:35:32
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
`ifndef MAC_TX_BASE_SEQS
`define MAC_TX_BASE_SEQS
class mac_tx_base_seqs extends uvm_sequence #(mac_tx_seq_item);
    
    bit [2:0] port_id;
    bit [11:0] vlan;

    `uvm_object_utils(mac_tx_base_seqs)

    function new(string name="");
        super.new(name);
    endfunction

    endclass
`endif

