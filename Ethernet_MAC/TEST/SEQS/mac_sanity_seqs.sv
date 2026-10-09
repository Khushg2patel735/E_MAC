//======================================================================
// File Name      : mac_sanity_seqs.sv
// Module Name    : mac_sanity_seqs
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Language       : SystemVerilog
//
// Description    : Basic MAC TX sanity sequence.
//
// Functionality  : Generates one MAC frame with a fixed payload size
//                  while using the port_id and vlan supplied by the
//                  parent sequence.
//
//======================================================================

`ifndef MAC_SANITY_SEQS_SV
`define MAC_SANITY_SEQS_SV

class mac_sanity_seqs extends mac_tx_base_seqs;

    `uvm_object_utils(mac_sanity_seqs)

    function new(string name = "mac_sanity_seqs");
        super.new(name);
    endfunction

    task body();

        req = mac_tx_seq_item::type_id::create("req");

        start_item(req);

        if (!req.randomize() with {
            PAYLOAD.size() == 48;
            PORT_ID       == port_id;
            VLAN          == vlan;
            DA == 'h112233445566;
            SA == 'hAABBCCDDEEFF;
        }) begin

            `uvm_error("MAC_SANITY_SEQS",
                       $sformatf(
                       "Randomization failed for PORT_ID=%0d VLAN=%0h",
                       port_id,
                       vlan))
        end

        finish_item(req);

    endtask

endclass

`endif
