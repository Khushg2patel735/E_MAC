//======================================================================
// File Name      : mac_ral_reg_adapter.sv
// Module Name    : mac_ral_reg_adapter
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-19 18:18:13
// Last Modified  : 2026-09-09 11:48:12
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
`ifndef REG_ADAPTER
`define REG_ADAPTER
class mac_ral_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(mac_ral_reg_adapter)

    bit [31:0] data;

    function new(string name="");
        super.new(name);
    endfunction

//=========================REG2BUS=========================//
    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);

        axi_lite_mas_sequence_item#(32,32) bus_item;
        bus_item = axi_lite_mas_sequence_item#(32,32)::type_id::create("bus_item");

        case(rw.kind)
        UVM_WRITE:begin
                    bus_item.axi_op_e = AXI_LITE_WRITE;
                    bus_item.addr     = rw.addr;
                    bus_item.w_data   = rw.data;
                  end

        UVM_READ:begin
                    bus_item.axi_op_e = AXI_LITE_READ;
                    bus_item.r_addr   = rw.addr;
                 end
        endcase

        return bus_item;
    endfunction

//=========================BUS2REG=========================//
    function void bus2reg(uvm_sequence_item bus_item,
                          ref uvm_reg_bus_op rw);

        axi_lite_mas_sequence_item #(32,32) seq_item;

        if(!$cast(seq_item,bus_item))
            `uvm_error("Casting_B2R","Casting fail between Bus_item to Seq_item")

      //  rw.kind = seq_item.axi_op_e;

        case(seq_item.axi_op_e)
        AXI_LITE_WRITE:begin
                         rw.kind   = UVM_WRITE;
                         rw.addr   = seq_item.addr;
                         rw.data   = seq_item.w_data;
                         rw.status = UVM_IS_OK;
                       end

        AXI_LITE_READ:begin
                         rw.kind   = UVM_READ;
                         rw.addr   = seq_item.r_addr;
                         rw.data   = seq_item.r_data;
                         rw.status = UVM_IS_OK;
                       end
        endcase

    endfunction
endclass
`endif

