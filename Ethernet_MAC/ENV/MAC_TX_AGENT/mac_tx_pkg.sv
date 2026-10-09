//======================================================================
// File Name      : mac_tx_pkg.sv
// Module Name    : mac_tx_pkg
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 01:46:27
// Last Modified  : 2026-10-07 21:02:49
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
`ifndef MAC_TX_PKG_SV
`define MAC_TX_PKG_SV

`include "uvm_macros.svh"
package mac_tx_pkg;
import uvm_pkg::*;
import axi_str_mas_pkg::*;

`include "mac_tx_defines.sv"
`include "mac_tx_config.sv"
`include "mac_tx_seq_item.sv"
`include "mac_tx_seqr.sv"
`include "mac_tx_mon.sv"
`include "mac_tx_adapter.sv"
`include "mac_tx_agent.sv"
`include "mac_tx_uvc.sv"
`include "mac_tx_base_seqs.sv"

endpackage
`endif
