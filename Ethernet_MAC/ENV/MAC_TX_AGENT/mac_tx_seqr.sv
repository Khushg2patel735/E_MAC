//======================================================================
// File Name      : mac_tx_seqr.sv
// Module Name    : mac_tx_seqr
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 00:00:28
// Last Modified  : 2026-08-16 03:14:30
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
`ifndef MAC_TX_SEQR_SV
`define MAC_TX_SEQR_SV

class mac_tx_seqr extends uvm_sequencer #(mac_tx_seq_item);

    `uvm_component_utils(mac_tx_seqr)

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

endclass
`endif

