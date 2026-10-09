//======================================================================
// File Name      : mac_ral_reg_block.sv
// Module Name    : mac_ral_reg_block
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-19 18:18:13
// Last Modified  : 2026-10-08 16:57:30
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
`ifndef MAC_RAL_REG_BLOCK
`define MAC_RAL_REG_BLOCK
class mac_ral_reg_block extends uvm_reg_block;

    `uvm_object_utils(mac_ral_reg_block)

    rand connection_id_reg id_reg_h[];
    rand output_port_reg out_port_reg_h[];

         uvm_reg_map id_reg_map,output_reg_map;
    function new (string name="");
        super.new(name,
                  UVM_NO_COVERAGE);
    endfunction

    function void build();
    id_reg_map = create_map("id_reg_map",
                             'h4000,
                             'h4,
                              UVM_LITTLE_ENDIAN
                            );

    output_reg_map = create_map("output_reg_map",
                                'h3000,
                                'h4,
                                UVM_LITTLE_ENDIAN
                               );

    id_reg_h = new['h8000];
    out_port_reg_h = new['h32];

    foreach(id_reg_h[i])begin
        id_reg_h[i] = connection_id_reg::type_id::create($sformatf("id_reg_h[%0d]",i));
        id_reg_h[i].configure(this);
        id_reg_h[i].build();

        id_reg_map.add_reg(id_reg_h[i],
                           i,
                           "RW");
    end

    foreach(out_port_reg_h[i])begin
        out_port_reg_h[i] = output_port_reg::type_id::create($sformatf("out_port_reg_h[%0d]",i));
        out_port_reg_h[i].configure(this);
        out_port_reg_h[i].build();

        output_reg_map.add_reg(out_port_reg_h[i],
                               i,
                               "RW");
    end

    lock_model();
    endfunction
endclass
`endif

