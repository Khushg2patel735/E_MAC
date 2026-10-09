//======================================================================
// File Name      : mac_sanity_test.sv
// Module Name    : mac_sanity_test
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-20 23:11:19
// Last Modified  : 2026-10-08 16:44:16
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
`ifndef MAC_SANITY_TEST_SV
`define MAC_SANITY_TEST_SV

class mac_sanity_test extends mac_base_test;

    `uvm_component_utils(mac_sanity_test)
    mac_sanity_vseqs vseqs_h;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        vseqs_h = mac_sanity_vseqs::type_id::create("vseqs_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        vseqs_h.start(env_h.vseqr_h);
        #1000;
        phase.drop_objection(this);
    endtask
endclass
`endif


