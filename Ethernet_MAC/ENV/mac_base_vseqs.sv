//======================================================================
// File Name      : mac_base_vseqs.sv
// Module Name    : mac_base_vseqs
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-20 19:46:39
// Last Modified  : 2026-10-08 11:52:00
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
`ifndef MAC_BASE_VSEQS
`define MAC_BASE_VSEQS

class mac_base_vseqs extends uvm_sequence #(uvm_sequence_item);
  
  `uvm_object_utils(mac_base_vseqs)
  
    mac_tx_seq_item mac_tx_seq_item_h;
  	mac_vseqr vseqr_h;
    
    bit [2:0] l_port_id;
  rand bit [11:0] l_vlan;
    bit [14:0] l_addr;
    rand bit [4:0] con_id;

    constraint L_VLAN_RNG {l_vlan inside {[12'h1:12'hFFF]};}
    constraint CON_ID {con_id inside {[0:31]};}
   // constraint CON_V {con_id[7] == 1;}
    mac_ral_reg_block reg_block_h;
    
    function new(string name="");
        super.new(name);
    endfunction

    task pre_start();
        if(!$cast(vseqr_h,m_sequencer))
            `uvm_fatal("Casting","Castin fail");
        reg_block_h = vseqr_h.reg_block_h;

//        reg_block_h.con_id = this.con_id;
    endtask

endclass
`endif

