//======================================================================
// File Name      : ral_base_seqs.sv
// Module Name    : ral_base_seqs
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Language       : SystemVerilog
//
// Description    : Base sequence for EMAC RAL operations.
//
//======================================================================

`ifndef RAL_BASE_SEQS_SV
`define RAL_BASE_SEQS_SV

class ral_base_seqs extends uvm_sequence #(uvm_sequence_item);

    `uvm_object_utils(ral_base_seqs)

    mac_vseqr         vseqr_h;
    mac_ral_reg_block reg_block_h;

    function new(string name = "ral_base_seqs");
        super.new(name);
    endfunction

    task pre_start();

        if (!$cast(vseqr_h, m_sequencer)) begin
            `uvm_fatal("RAL_BASE_SEQS",
                       "Failed to cast m_sequencer to mac_vseqr")
        end

        reg_block_h = vseqr_h.reg_block_h;

        if (reg_block_h == null) begin
            `uvm_fatal("RAL_BASE_SEQS",
                       "RAL register block handle is NULL")
        end

    endtask

endclass

`endif
