//======================================================================
// File Name      : mac_base_test.sv
// Module Name    : mac_base_test
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 02:02:24
// Last Modified  : 2026-09-08 18:37:19
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
`ifndef MAC_BASE_TEST_SV
`define MAC_BASE_TEST_SV

class mac_base_test extends uvm_test;

    `uvm_component_utils(mac_base_test)
    mac_env env_h;
    mac_tx2rx_config mac_tx2rx_cfg_h;

    function new(string name="", uvm_component parent);
        super.new(name,parent);
    endfunction

   virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env_h = mac_env::type_id::create("env_h",this);

        mac_tx2rx_cfg_h = mac_tx2rx_config::type_id::create("mac_tx2rx_cfg_h");

        mac_tx2rx_cfg_h.no_of_mac_tx_agent = 3;
        mac_tx2rx_cfg_h.no_of_axis_mas     = 3;
        mac_tx2rx_cfg_h.no_of_axi_lite_mas = 1;
        mac_tx2rx_cfg_h.is_active     = UVM_ACTIVE;

        uvm_config_db #(mac_tx2rx_config)::set(this,"*","mac_tx2rx_cfg_h",mac_tx2rx_cfg_h);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

endclass
`endif


