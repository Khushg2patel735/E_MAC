//======================================================================
// File Name      : mac_tx_uvc.sv
// Module Name    : mac_tx_uvc
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 00:00:28
// Last Modified  : 2026-08-17 16:14:38
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
`ifndef MAC_TX_UVC_SV
`define MAC_TX_UVC_SV

class mac_tx_uvc extends uvm_agent;

    `uvm_component_utils(mac_tx_uvc)

    mac_tx_agent tx_agent_h[];
    mac_tx_config mac_tx_cfg_h;
    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(mac_tx_config)::get(this,"","mac_tx_cfg_h",mac_tx_cfg_h))
            `uvm_fatal("get_full_name()","Config_db_get fail for mac_tx_cfg_h")
        tx_agent_h = new[mac_tx_cfg_h.no_of_mac_tx_agent];
        foreach(tx_agent_h[i])begin
            tx_agent_h[i] = mac_tx_agent::type_id::create($sformatf("tx_agent_h[%0d]",i),this);
        end
    endfunction
endclass
`endif
