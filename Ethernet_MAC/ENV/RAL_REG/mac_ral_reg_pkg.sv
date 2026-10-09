//======================================================================
// File Name      : mac_ral_reg_pkg.sv
// Module Name    : mac_ral_reg_pkg
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-20 22:23:34
// Last Modified  : 2026-09-08 18:57:19
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
`ifndef MAC_RAL_REG_PKG_SV
`define MAC_RAL_REG_PKG_SV

`include "uvm_macros.svh"
package mac_ral_reg_pkg;
import uvm_pkg::*;
import axi_lite_pkg::*;

`include "mac_ral_reg.sv"
`include "mac_ral_reg_block.sv"
`include "mac_ral_reg_adapter.sv"

endpackage
`endif


