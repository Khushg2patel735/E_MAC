//======================================================================
// File Name      : mac_tx_agent.sv
// Module Name    : mac_tx_agent
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 00:00:28
// Last Modified  : 2026-08-18 16:38:33
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
`ifndef MAC_TX_AGENT_SV
`define MAC_TX_AGENT_SV

class mac_tx_agent extends uvm_agent;

    `uvm_component_utils(mac_tx_agent)

    mac_tx_seqr seqr_h;
    mac_tx_mon mon_h;

    mac_tx_adapter adp_seqs;//extends from axi_str_mas_base_seqs
    uvm_sequencer #(axi_str_mas_seq_item#(32,32)) axi_str_seqr;

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seqr_h = mac_tx_seqr::type_id::create("seqr_h",this);
        mon_h  = mac_tx_mon::type_id::create("mon_h",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        adp_seqs = mac_tx_adapter::type_id::create("adp_seqs");
        adp_seqs.mac_tx_rep_seqr = seqr_h;
    endfunction

    task run_phase(uvm_phase phase);
        adp_seqs.start(axi_str_seqr);
    endtask

    function void connect_axi_str_seqr(axi_str_mas_agent axi_str_mas_agent_h);
    this.axi_str_seqr = axi_str_mas_agent_h.master_seqr;
    endfunction
endclass
`endif


