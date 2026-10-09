`ifndef AXIL_TB_TOP_SV
`define AXIL_TB_TOP_SV

`timescale 1ns/1ns
`include "axil_env_pkg.sv"
`include "axil_test_pkg.sv"
`include "axil_master_if.sv"

module axil_tb_top;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import axil_env_pkg::*;
  import axil_test_pkg::*;
  
  axil_master_if axil_master_vif();

  // Clock Generation
  initial begin
    axil_master_vif.aclk = 1'b0;
    forever #20 axil_master_vif.aclk = ~axil_master_vif.aclk; // 25 MHz clock
  end

  // Reset Generation
  initial begin
    axil_master_vif.ARESETn <= 1'b0;
    #100;
    axil_master_vif.ARESETn <= 1'b1;
  end

  //------------------------------------------------------------------
  // Dummy Slave Responder Logic (Fixed ready & response generation)
  //------------------------------------------------------------------

  // 1. Address Ready Signals (Always ready to receive addresses)
  initial begin
    axil_master_vif.awready = 1'b0;
    axil_master_vif.arready = 1'b0;
    axil_master_vif.wready  = 1'b0;

    wait(axil_master_vif.ARESETn == 1'b1);
    
    forever begin
      @(posedge axil_master_vif.aclk);
      axil_master_vif.awready <= 1'b1;
      axil_master_vif.arready <= 1'b1;
      axil_master_vif.wready  <= 1'b1;
    end
  end

  // 2. Read Response Handler
  initial begin
    axil_master_vif.rvalid = 1'b0;
    axil_master_vif.rlast  = 1'b0;
    axil_master_vif.rdata  = '0;
    axil_master_vif.rresp  = '0;

    wait(axil_master_vif.ARESETn == 1'b1);

    forever begin
      // Wait for Read Address Handshake
      @(posedge axil_master_vif.aclk iff (axil_master_vif.arvalid && axil_master_vif.arready));
      
      // Drive Read Data Phase (Handled properly even if arlen = 0)
      axil_master_vif.rid    <= axil_master_vif.arid;
      axil_master_vif.rvalid <= 1'b1;
      axil_master_vif.rlast  <= 1'b1;
      axil_master_vif.rdata  <= $urandom_range(1, 500);
      axil_master_vif.rresp  <= 2'b00; // OKAY response

      // Wait for Master RREADY Handshake
      @(posedge axil_master_vif.aclk iff axil_master_vif.rready);
      axil_master_vif.rvalid <= 1'b0;
      axil_master_vif.rlast  <= 1'b0;
    end
  end

  // 3. Write Response Handler
  initial begin
    axil_master_vif.bvalid = 1'b0;
    axil_master_vif.bresp  = 2'b00;

    wait(axil_master_vif.ARESETn == 1'b1);

    forever begin
      // Wait for Write Data & WLAST Handshake
      @(posedge axil_master_vif.aclk iff (axil_master_vif.wvalid && axil_master_vif.wready && axil_master_vif.wlast));
      
      axil_master_vif.bvalid <= 1'b1;

      // Wait for Master BREADY Handshake
      @(posedge axil_master_vif.aclk iff axil_master_vif.bready);
      axil_master_vif.bvalid <= 1'b0;
    end
  end

  // UVM Test Execution
  initial begin
    uvm_top.set_report_verbosity_level(UVM_DEBUG);
    uvm_config_db#(virtual axil_master_if)::set(null, "*", "vif", axil_master_vif);
    run_test("axil_base_test");
  end

endmodule

`endif // AXIL_TB_TOP_SV
