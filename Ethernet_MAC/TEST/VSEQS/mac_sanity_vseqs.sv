//======================================================================
// File Name      : mac_sanity_vseqs.sv
// Module Name    : mac_sanity_vseqs
// Project        : Ethernet_MAC
// Author         : Khush Patel
// Language       : SystemVerilog
//
// Description    : EMAC sanity virtual sequence.
//
// Functionality  :
//   1. Configure connection table through RAL.
//   2. Configure output port mapping through RAL.
//   3. Generate MAC traffic on all three ingress ports.
//
// Port Mapping:
//   In_Port0 -> PORT_ID 3 -> OUT_PORT 8
//   In_Port1 -> PORT_ID 4 -> OUT_PORT 9
//   In_Port2 -> PORT_ID 5 -> OUT_PORT 10
//
//======================================================================

`ifndef MAC_SANITY_VSEQS_SV
`define MAC_SANITY_VSEQS_SV

class mac_sanity_vseqs extends mac_base_vseqs;

    `uvm_object_utils(mac_sanity_vseqs)

    mac_sanity_seqs seqs1_h[];

    function new(string name = "mac_sanity_vseqs");
        super.new(name);
    endfunction

    task body();

        uvm_status_e status;

        bit [4:0]  connection_id;
        bit [31:0] connection_data;
        bit [3:0]  output_port;

        // -------------------------------------------------------------
        // Create one MAC sequence for each ingress port
        // -------------------------------------------------------------
        seqs1_h = new[vseqr_h.mac_tx_seqr_h.size()];

        foreach (seqs1_h[i]) begin

            seqs1_h[i] =
                mac_sanity_seqs::type_id::create(
                    $sformatf("seqs1_h[%0d]", i)
                );

            // ---------------------------------------------------------
            // Port mapping
            //
            // i = 0 -> PORT_ID 3 -> OUT_PORT 8
            // i = 1 -> PORT_ID 4 -> OUT_PORT 9
            // i = 2 -> PORT_ID 5 -> OUT_PORT 10
            // ---------------------------------------------------------
            l_port_id = 3 + i;
            l_vlan = 12'h01c;
            // Generate VLAN for this connection
            /*if (!randomize(l_vlan == 12'h01c)) begin
                `uvm_fatal(
                    "L_VLAN",
                    $sformatf(
                        "Failed to randomize VLAN for PORT_ID=%0d",
                        l_port_id
                    )
                )
            end*/

            // ---------------------------------------------------------
            // Connection ID
            //
            // For sanity:
            // PORT 3 -> CID 0
            // PORT 4 -> CID 1
            // PORT 5 -> CID 2
            // ---------------------------------------------------------
            connection_id = i;

            // ---------------------------------------------------------
            // Connection configuration address
            //
            // Address offset = {PORT_ID,VLAN}
            // Physical address is handled by id_reg_map base 0x4000.
            // ---------------------------------------------------------
            l_addr = {l_port_id, l_vlan};

            // ---------------------------------------------------------
            // Connection register data
            //
            // Bit [7]   = valid
            // Bits [4:0] = connection ID
            // ---------------------------------------------------------
            connection_data = '0;
            connection_data[7]   = 1'b1;
            connection_data[4:0] = connection_id;

            // ---------------------------------------------------------
            // Output port mapping
            // ---------------------------------------------------------
            output_port = 8 + i;

            // ---------------------------------------------------------
            // RAL WRITE #1
            //
            // Configure:
            // {PORT_ID,VLAN} -> Connection ID
            // ---------------------------------------------------------
            reg_block_h.id_reg_h[l_addr].write(
                status,
                connection_data
            );

            if (status != UVM_IS_OK) begin
                `uvm_error(
                    "RAL_WRITE",
                    $sformatf(
                        "Connection register write failed: PORT_ID=%0d VLAN=%0h ADDR=%0h CID=%0d STATUS=%s",
                        l_port_id,
                        l_vlan,
                        l_addr,
                        connection_id,
                        status.name()
                    )
                )
            end

            // ---------------------------------------------------------
            // RAL WRITE #2
            //
            // Configure:
            // Connection ID -> Output Port
            // ---------------------------------------------------------
            reg_block_h.out_port_reg_h[connection_id].write(
                status,
                output_port
            );

            if (status != UVM_IS_OK) begin
                `uvm_error(
                    "RAL_WRITE",
                    $sformatf(
                        "Output port register write failed: CID=%0d OUT_PORT=%0d STATUS=%s",
                        connection_id,
                        output_port,
                        status.name()
                    )
                )
            end

            // ---------------------------------------------------------
            // Pass configuration to MAC sequence
            // ---------------------------------------------------------
            seqs1_h[i].port_id = l_port_id;
            seqs1_h[i].vlan    = l_vlan;

            // ---------------------------------------------------------
            // Debug information
            // ---------------------------------------------------------
            `uvm_info(
                "SANITY_CFG",
                $sformatf(
                    "PORT_ID=%0d VLAN=%03h CONNECTION_ID=%0d OUT_PORT=%0d OFFSET=%0h",
                    l_port_id,
                    l_vlan,
                    connection_id,
                    output_port,
                    l_addr
                ),
                UVM_MEDIUM
            )

        end

        // -------------------------------------------------------------
        // Start all three MAC traffic sequences in parallel
        // -------------------------------------------------------------
        fork

              //  seqs1_h[0].start(vseqr_h.mac_tx_seqr_h[0]);
            foreach (seqs1_h[i])
                seqs1_h[i].start(vseqr_h.mac_tx_seqr_h[i]);

        join

    endtask

endclass

`endif
