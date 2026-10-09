//======================================================================
// File Name      : mac_env.sv
// Module Name    : mac_env
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Created On     : 2026-08-16 00:30:50
// Last Modified  : 2026-09-10 17:23:53
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
`ifndef MAC_ENV_SV
`define MAC_ENV_SV

class mac_env extends uvm_env;

    `uvm_component_utils(mac_env)

    mac_vseqr vseqr_h;

    mac_tx_uvc tx_uvc_h;
    axi_str_mas_uvc #(32,32) axi_str_mas_uvc_h;
    axi_lite_mas_uvc axi_lite_mas_uvc_h;

    mac_tx2rx_config mac_tx2rx_cfg_h;
    mac_tx_config mac_tx_cfg_h;
    axi_str_mas_config axi_str_mas_cfg_h;
    axi_lite_mas_cfg axi_lite_mas_cfg_h;

    mac_ral_reg_block reg_block_h;
    mac_ral_reg_adapter reg_adapter_h;

    function new(string name = "",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tx_uvc_h = mac_tx_uvc::type_id::create("tx_uvc_h",this);

        if(!uvm_config_db #(mac_tx2rx_config)::get(this,"","mac_tx2rx_cfg_h",mac_tx2rx_cfg_h))
            `uvm_fatal("get_full_name()","Config_db_get fail for mac_tx2rx_cfg_h")

        axi_str_mas_cfg_h = axi_str_mas_config::type_id::create("axi_str_mas_cfg_h");
        mac_tx_cfg_h = mac_tx_config::type_id::create("mac_tx_cfg_h");
        axi_lite_mas_cfg_h = axi_lite_mas_cfg::type_id::create("axi_str_mas_cfg_h");

        mac_tx_cfg_h.no_of_mac_tx_agent = mac_tx2rx_cfg_h.no_of_mac_tx_agent;
        axi_str_mas_cfg_h.no_of_axis_mas = mac_tx2rx_cfg_h.no_of_axis_mas;
        axi_lite_mas_cfg_h.no_of_axi_lite_mas = mac_tx2rx_cfg_h.no_of_axi_lite_mas;
      //  axi_lite_mas_cfg_h.is_active = mac_tx2rx_cfg_h.is_active;

        uvm_config_db #(mac_tx_config)::set(this,"*","mac_tx_cfg_h",mac_tx_cfg_h);
        uvm_config_db #(axi_str_mas_config)::set(this,"*","no_master",axi_str_mas_cfg_h);
        uvm_config_db #(axi_lite_mas_cfg)::set(this,"*","no_master",axi_lite_mas_cfg_h);

        axi_str_mas_uvc_h = axi_str_mas_uvc#(32,32)::type_id::create("axi_str_mas_uvc_h",this);
        axi_lite_mas_uvc_h = axi_lite_mas_uvc::type_id::create("axi_lite_mas_uvc_h",this);

        vseqr_h = mac_vseqr::type_id::create("vseqr_h",this);

        vseqr_h.mac_tx_seqr_h = new[mac_tx2rx_cfg_h.no_of_mac_tx_agent];
        vseqr_h.axi_str_mas_seqr_h = new[mac_tx2rx_cfg_h.no_of_axis_mas];
        vseqr_h.axi_lite_mas_seqr_h = new[mac_tx2rx_cfg_h.no_of_axi_lite_mas];

        reg_block_h = mac_ral_reg_block::type_id::create("reg_block_h");
        reg_block_h.build();

        reg_adapter_h = mac_ral_reg_adapter::type_id::create("reg_adapter_h");

    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    foreach(tx_uvc_h.tx_agent_h[i])
    begin
        tx_uvc_h.tx_agent_h[i].connect_axi_str_seqr(axi_str_mas_uvc_h.master_agent[i]);
    end

    //Here i consider the number of EMAC_agent and AXI_STR agent are same so i take it as a i = No_of_mac_tx_agent => 3;
    for(int i=0; i<mac_tx2rx_cfg_h.no_of_mac_tx_agent; i++)
        begin
            vseqr_h.mac_tx_seqr_h[i] = tx_uvc_h.tx_agent_h[i].seqr_h;
            vseqr_h.axi_str_mas_seqr_h[i] = axi_str_mas_uvc_h.master_agent[i].master_seqr;
            //vseqr_h.axi_str_slv_seqr_h[i] = axi_str_slv_uvc_h.slave_agent[i].slave_seqr;
        end

    for(int i=0; i<mac_tx2rx_cfg_h.no_of_axi_lite_mas; i++)
        begin
            vseqr_h.axi_lite_mas_seqr_h[i] = axi_lite_mas_uvc_h.axi_lite_m_agent[i].m_seqr;
        end

            vseqr_h.reg_block_h = reg_block_h;

            reg_block_h.id_reg_map.set_sequencer(
                                                  axi_lite_mas_uvc_h.axi_lite_m_agent[0].m_seqr,
                                                  reg_adapter_h
                                                 );
            reg_block_h.output_reg_map.set_sequencer(
                                                  axi_lite_mas_uvc_h.axi_lite_m_agent[0].m_seqr,
                                                  reg_adapter_h
                                                 );


`uvm_info("RAL_CONNECT",
          $sformatf(
            "AFTER set_sequencer(): sequencer=%s adapter=%s",
            axi_lite_mas_uvc_h.axi_lite_m_agent[0].m_seqr.get_full_name(),
            reg_adapter_h.get_full_name()
          ),
          UVM_LOW)
    endfunction

endclass 

`endif

