//======================================================================
// File Name      : mac_tx_seq_item.sv
// Module Name    : mac_tx_seq_item
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-15 18:53:43
// Last Modified  : 2026-10-08 12:25:48
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
`ifndef MAC_TX_SEQ_ITEM_SV
`define MAC_TX_SEQ_ITEM_SV
class mac_tx_seq_item extends uvm_sequence_item;

    rand bit [`ADDR_W-1:0] DA;
    rand bit [`ADDR_W-1:0] SA;
    rand bit [15:0]        ETYPE;
    rand bit [15:0]        TCI;

    rand bit [2:0]         PCP;
    rand bit               DEI;
    rand bit [11:0]        VLAN;

    rand bit [7:0]         PAYLOAD[];
    
    rand bit [31:0]        PKG_SIZE;

    rand bit [2:0]         PORT_ID;
//    TCI = {PCP,DEI,VLAN};

    `uvm_object_utils_begin(mac_tx_seq_item)
        `uvm_field_int(DA,UVM_ALL_ON)
        `uvm_field_int(SA,UVM_ALL_ON)
        `uvm_field_int(ETYPE,UVM_ALL_ON)
        `uvm_field_int(TCI,UVM_ALL_ON)
        `uvm_field_int(PCP,UVM_ALL_ON)
        `uvm_field_int(DEI,UVM_ALL_ON)
        `uvm_field_int(VLAN,UVM_ALL_ON)
        `uvm_field_int(PKG_SIZE,UVM_ALL_ON)
        `uvm_field_int(PORT_ID,UVM_ALL_ON)
        `uvm_field_array_int(PAYLOAD,UVM_ALL_ON)
    `uvm_object_utils_end

    constraint ETYPE_OPETION {ETYPE inside {16'h8100,16'h0800};}
    constraint PAYLOAD_RANGE  {PAYLOAD.size() inside {[46:1500]};}

    function new(string name="");
        super.new(name);
    endfunction

    function void post_randomize();
        TCI = {DEI,PCP,VLAN};
        PKG_SIZE = 'd6+'d6+'d2+'d2+PAYLOAD.size();
        `uvm_info("POST_RAND",$sformatf("PKG_SIZE = %0d",PKG_SIZE),UVM_MEDIUM)
    endfunction
endclass
`endif

