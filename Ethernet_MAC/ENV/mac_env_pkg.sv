//======================================================================
// File Name      : mac_env_pkg.sv
// Module Name    : mac_env_pkg
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 01:59:05
// Last Modified  : 2026-09-08 18:57:09
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
`ifndef MAC_ENV_PKG_SV
`define MAC_ENV_PKG_SV

`include "uvm_macros.svh"
package mac_env_pkg;
import uvm_pkg::*;
import mac_tx_pkg::*;
import mac_ral_reg_pkg::*;

import axi_str_mas_pkg::*;
import axi_str_slv_pkg::*;
import axi_str_env_pkg::*;
import axi_lite_pkg::*;

`include "mac_tx2rx_config.sv"
`include "mac_vseqr.sv"
`include "mac_env.sv"
`include "mac_base_vseqs.sv"

endpackage
`endif

