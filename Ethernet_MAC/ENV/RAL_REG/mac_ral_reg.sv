//======================================================================
// File Name      : mac_ral_reg.sv
// Module Name    : mac_ral_reg
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-19 18:18:13
// Last Modified  : 2026-10-08 11:55:32
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
class connection_id_reg extends uvm_reg;
    
    `uvm_object_utils(connection_id_reg)

    rand uvm_reg_field connection_id;
    rand uvm_reg_field rsv1;
    rand uvm_reg_field connection_valid;
    rand uvm_reg_field rsv2;

    function new(string name="");
        super.new(name,
                  32,
                  UVM_NO_COVERAGE);
    endfunction

    function void build();

        connection_id = uvm_reg_field::type_id::create("connection_id");
        connection_id.configure(.parent(this),
                                .size(5),
                                .lsb_pos(0),
                                .access("RW"),
                                .volatile(0),
                                .reset(0),
                                .has_reset(1),
                                .is_rand(1),
                                .individually_accessible(0));

        rsv1 = uvm_reg_field::type_id::create("rsv1");
        rsv1.configure(.parent(this),
                      .size(2),
                      .lsb_pos(5),
                      .access("RO"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(0),
                      .is_rand(0),
                      .individually_accessible(0));

        connection_valid = uvm_reg_field::type_id::create("connection_valid");
        connection_valid.configure(.parent(this),
                                   .size(1),
                                   .lsb_pos(7),
                                   .access("RW"),
                                   .volatile(0),
                                   .reset(0),
                                   .has_reset(1),
                                   .is_rand(0),
                                   .individually_accessible(0));

        rsv2 = uvm_reg_field::type_id::create("rsv2");
        rsv2.configure(.parent(this),
                      .size(24),
                      .lsb_pos(8),
                      .access("RO"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(0),
                      .is_rand(0),
                      .individually_accessible(0));

    endfunction
endclass

class output_port_reg extends uvm_reg;

    `uvm_object_utils(output_port_reg)

    rand uvm_reg_field output_port_sel;
    rand uvm_reg_field rsv;

    function new(string name="");
        super.new(name,
                  32,
                  UVM_NO_COVERAGE);
    endfunction

    function void build();

        output_port_sel = uvm_reg_field::type_id::create("output_port_sel");
        output_port_sel.configure(.parent(this),
                                  .size(4),
                                  .lsb_pos(0),
                                  .access("RW"),
                                  .volatile(0),
                                  .reset(0),
                                  .has_reset(1),
                                  .is_rand(1),
                                  .individually_accessible(0));

        rsv = uvm_reg_field::type_id::create("rsv");
        rsv.configure(.parent(this),
                      .size(28),
                      .lsb_pos(4),
                      .access("RO"),
                      .volatile(0),
                      .reset(0),
                      .has_reset(0),
                      .is_rand(0),
                      .individually_accessible(0));
    endfunction
endclass
