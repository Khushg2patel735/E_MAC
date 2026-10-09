//======================================================================
// File Name      : mac_vseqr.sv
// Module Name    : mac_vseqr
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-20 19:22:57
// Last Modified  : 2026-09-09 11:47:11
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
`ifndef MAC_VSEQR
`define MAC_VSEQR
class mac_vseqr extends uvm_sequencer;

    `uvm_component_utils(mac_vseqr)

    function new(string name="",uvm_component parent);
        super.new(name,parent);
    endfunction

    mac_tx_seqr mac_tx_seqr_h[];
    axi_str_mas_sequencer#(32,32) axi_str_mas_seqr_h[];
    axi_str_slv_sequencer#(32,32) axi_str_slv_seqr_h[];
    axi_lite_mas_sequencer#(32,32) axi_lite_mas_seqr_h[];

    mac_ral_reg_block reg_block_h;
endclass
`endif

