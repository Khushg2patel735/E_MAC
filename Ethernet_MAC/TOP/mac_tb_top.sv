//======================================================================
// File Name      : mac_tb_top.sv
// Module Name    : mac_tb_top
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 02:06:46
// Last Modified  : 2026-10-08 17:33:18
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
`ifndef MAC_TOP
`define MAC_TOP

`include "uvm_macros.svh"
`include "mac_tx_defines.sv"
`include "axi_str_mas_inf.sv"
`include "mac_test_pkg.sv"
`include "axi_lite_inf.sv"

//---------- TOP ----------
module mac_tb_top;
import uvm_pkg::*;
import mac_test_pkg::*;

    //----------------TB_CLK----------------
    bit ACLK;
    initial begin
        ACLK = 0;
        forever #5 ACLK = ~ACLK;
    end
    
    //----------------RTL_CLK----------------
    bit RTL_ACLK;
    initial begin
        RTL_ACLK = 0;
        forever #5 RTL_ACLK = ~RTL_ACLK;
    end
    
    initial begin
        axi_lite_inf_h.ACLK = 0;
        forever #5 axi_lite_inf_h.ACLK = ~axi_lite_inf_h.ACLK;
    end
    

    //----------------TB_Interface----------------
    axi_str_slv_inf#(32,32) axi_str_in_inf_h [3](ACLK);
    axi_str_mas_inf#(32,32) axi_str_out_inf_h[3](ACLK);
    axi_lite_mas_interface#(32,32) axi_lite_inf_h();

    //----------------DUT_Interface----------------
    axi_str_master_inf#(32,1) axi_str_mas_rtl_h[3]();
    axi_str_slave_inf#(32,1) axi_str_slv_rtl_h[3]();
    axi_lite_inf#(32,32,32) axi_lite_inf_rtl_h();
    
    //----------------RESET----------------
    bit reset_n;
    bit reset_reg;
    bit ARESETn;

    initial begin
        reset_n = 1'b0;
        reset_reg = 1'b0;
        ARESETn = 1'b0;
        rtl_dut.axi_out_arb.reset_n = 1'b0;
        axi_lite_inf_h.ARESETn = 1'b0;
        axi_lite_inf_rtl_h.reset_n = 1'b0;
    @(posedge ACLK);
        reset_n = 1'b1;
        reset_reg = 1'b1;
        ARESETn = 1'b1;
        axi_lite_inf_h.ARESETn = 1'b1;
        rtl_dut.axi_out_arb.reset_n = 1'b1;
        axi_lite_inf_rtl_h.reset_n = 1'b1;
    end

    //----------------DUT_INST----------------
    top #(
          .NUM_OF_PORT(3),
          .NUM_OF_PORT_OUT(3),
          .ADDR_SIZE(32),
          .DATA_SIZE(32),
          .ID_SIZE(32),
          .USER_SIZE(16), 
          .TDATA_SIZE(32)
         )  
     rtl_dut (
          .clk        (ACLK),
          .reset_n    (reset_n),
          .reset_reg  (reset_reg),
          .clk_reg    (RTL_ACLK),
          .axi_in_inf (axi_str_slv_rtl_h),
          .axi_out_inf(axi_str_mas_rtl_h),
          .axi_lite   (axi_lite_inf_rtl_h)
          );

/*
    //----------------DUT_Interface & TB_Interface----------------//
        T_M  axi_str_out_inf_h            D_M  axi_str_mas_rtl_h
        D_S  axi_str_slv_rtl_h            T_S  axi_str_in_inf_h
*/

    //----------------D_S <=> T_M----------------
    genvar i;
    generate
        for (i = 0; i < 3; i++) begin
            assign axi_str_slv_rtl_h[i].reset_n  = reset_n;
            assign axi_str_out_inf_h[i].areset_n = ARESETn;

            //assign axi_str_out_inf_h[i].tready   = axi_str_slv_rtl_h[i].tready;

            assign axi_str_slv_rtl_h[i].tvalid   = axi_str_out_inf_h[i].tvalid;
            assign axi_str_slv_rtl_h[i].tkeep    = axi_str_out_inf_h[i].tkeep;
            assign axi_str_slv_rtl_h[i].tlast    = axi_str_out_inf_h[i].tlast;
            assign axi_str_slv_rtl_h[i].tdata    = axi_str_out_inf_h[i].tdata;
            assign axi_str_slv_rtl_h[i].tuser    = axi_str_out_inf_h[i].tuser;

            assign axi_str_out_inf_h[i].tready   = axi_str_slv_rtl_h[i].tready;
            //assign axi_str_slv_rtl_h[i].tready   = 1'b1;
        end
    endgenerate

    //----------------D_M <=> T_S----------------
    genvar j;
    generate
        for (j = 0; j < 3; j++) begin
            assign axi_str_mas_rtl_h[j].reset_n  = ARESETn;
            assign axi_str_in_inf_h[j].areset_n  = ARESETn;

            assign axi_str_in_inf_h[j].tvalid    = axi_str_mas_rtl_h[j].tvalid;
            assign axi_str_in_inf_h[j].tkeep     = axi_str_mas_rtl_h[j].tkeep;
            assign axi_str_in_inf_h[j].tlast     = axi_str_mas_rtl_h[j].tlast;
            assign axi_str_in_inf_h[j].tdata     = axi_str_mas_rtl_h[j].tdata;
            assign axi_str_in_inf_h[j].tuser     = axi_str_mas_rtl_h[j].tuser;

            assign axi_str_mas_rtl_h[j].tready   = 1'b1;//axi_str_in_inf_h[j].tready; 
            assign axi_str_in_inf_h[j].tready    = 1'b1;
        end
    endgenerate

            //  assign axi_out_arb.tready = 1'b1;
            //  assign axi_in_
       //     assign axi_str_mas_rtl_h[0].tready   = 1'b1; 
    //----------------TB => DUT----------------
            assign axi_lite_inf_rtl_h.awaddr  = axi_lite_inf_h.AWADDR;
            assign axi_lite_inf_rtl_h.awvalid = axi_lite_inf_h.AWVALID;
            assign axi_lite_inf_rtl_h.wdata   = axi_lite_inf_h.WDATA;
            assign axi_lite_inf_rtl_h.wstrb   = 4'hF;
            assign axi_lite_inf_rtl_h.wvalid  = axi_lite_inf_h.WVALID;
            assign axi_lite_inf_rtl_h.bready  = axi_lite_inf_h.BREADY;
            assign axi_lite_inf_rtl_h.araddr  = axi_lite_inf_h.ARADDR;
            assign axi_lite_inf_rtl_h.arvalid = axi_lite_inf_h.ARVALID;
            assign axi_lite_inf_rtl_h.rready  = axi_lite_inf_h.RREADY;

    //----------------DUT => TB----------------
            assign axi_lite_inf_h.AWREADY = axi_lite_inf_rtl_h.awready;
            assign axi_lite_inf_h.ARREADY = axi_lite_inf_rtl_h.arready;
            assign axi_lite_inf_h.WREADY  = axi_lite_inf_rtl_h.wready;
            assign axi_lite_inf_h.BVALID  = axi_lite_inf_rtl_h.bvalid;
            assign axi_lite_inf_h.BRESP   = axi_lite_inf_rtl_h.bresp;
            assign axi_lite_inf_h.RDATA   = axi_lite_inf_rtl_h.rdata;
            assign axi_lite_inf_h.RVALID  = axi_lite_inf_rtl_h.rvalid;
            assign axi_lite_inf_h.RRESP   = axi_lite_inf_rtl_h.rresp;

    //----------------INTERFACE----------------
    initial begin
            uvm_config_db #(virtual axi_str_mas_inf #(32,32))::set(null,"uvm_test_top.env_h.axi_str_mas_uvc_h.master_agent[0]","vinf",axi_str_out_inf_h[0]);
            uvm_config_db #(virtual axi_str_mas_inf #(32,32))::set(null,"uvm_test_top.env_h.axi_str_mas_uvc_h.master_agent[1]","vinf",axi_str_out_inf_h[1]);
            uvm_config_db #(virtual axi_str_mas_inf #(32,32))::set(null,"uvm_test_top.env_h.axi_str_mas_uvc_h.master_agent[2]","vinf",axi_str_out_inf_h[2]);
            uvm_config_db #(virtual axi_lite_mas_interface#(32,32))::set(null,"uvm_test_top.env_h.axi_lite_mas_uvc_h.axi_lite_m_agent[0].*","vif",axi_lite_inf_h);
        run_test("mac_sanity_test");
    end
endmodule

`endif
