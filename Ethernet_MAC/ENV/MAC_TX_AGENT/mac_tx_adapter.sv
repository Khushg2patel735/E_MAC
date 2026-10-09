//======================================================================
// File Name      : mac_tx_adapter.sv
// Module Name    : mac_tx_adapter
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-18 11:58:51
// Last Modified  : 2026-10-09 15:12:23
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
`ifndef MAC_TX_ADAPTER
`define MAC_TX_ADAPTER
//`include "axi_str_mas_pkg.sv"
//`include "axi_str_mas_base_seqs.sv"
class mac_tx_adapter extends axi_str_mas_base_seqs #(32,32);

    `uvm_object_utils(mac_tx_adapter)

    function new(string name="");
        super.new(name);
    endfunction

    uvm_sequencer #(mac_tx_seq_item) mac_tx_rep_seqr;
    
    //import axi_str_mas_pkg::*;
    mac_tx_seq_item mac_tx_trans;
    bit [31:0] data_q[$];
    bit [31:0] data_q_temp[$];

    task body();
        forever begin 
        req = axi_str_mas_seq_item#(32,32)::type_id::create("req");
            mac_tx_rep_seqr.get_next_item(mac_tx_trans);
                mac_tx_trans.print();
                start_item(req);
                    cov_to_frame();
                    if(!req.randomize() with {req.total_bytes == mac_tx_trans.PKG_SIZE;
                                                       foreach(data_q[i])
                                                        {req.tdata_q[i] == data_q[i];
                                                        }
                                                       })
                    `uvm_error("ADP_Rand","Adapter_Randomize fail")
                    `uvm_info("ADAPTER",
                              $sformatf("AXI REQ total_bytes=%0d pkt_len=%0d",
                              req.total_bytes,
                              req.pkt_len),
                              UVM_LOW)

                    req.print();   
                finish_item(req);
            mac_tx_rep_seqr.item_done();
        end
    endtask
    function void cov_to_frame();
        data_q_temp = {>>{mac_tx_trans.DA,mac_tx_trans.SA,
                     mac_tx_trans.TCI,mac_tx_trans.ETYPE,
                     mac_tx_trans.PAYLOAD}};
        foreach(data_q_temp[i])begin
            `uvm_info("COV_TO_FRAME",$sformatf("TEMP Data_Q: %h",data_q_temp[i]),UVM_MEDIUM)
        data_q.push_back({<<8{data_q_temp[i]}});
            `uvm_info("COV_TO_FRAME",$sformatf("Actual Data_Q: %h",data_q[i]),UVM_MEDIUM)
    end
    endfunction
endclass
`endif

