//======================================================================
// File Name      : mac_test_pkg.sv
// Module Name    : mac_test_pkg
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 02:09:53
// Last Modified  : 2026-10-08 11:13:08
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
`ifndef MAC_TEST_PKG_SV
`define MAC_TEST_PKG_SV

`include "uvm_macros.svh"

package mac_test_pkg;

import uvm_pkg::*;
import mac_tx_pkg::*;
import mac_env_pkg::*;
import mac_ral_reg_pkg::*;

`include "ral_base_seqs.sv"
`include "mac_sanity_seqs.sv"
`include "mac_sanity_vseqs.sv"

`include "mac_base_test.sv"
`include "mac_sanity_test.sv"

endpackage

`endif

