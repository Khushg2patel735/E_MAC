
`ifndef AXIL_MASTER_SEQUENCER_SVH
`define AXIL_MASTER_SEQUENCER_SVH

class axil_master_sequencer #(shortint ADDR_SIZE=32,DATA_SIZE=32,ID_SIZE=32) extends uvm_sequencer #(axil_master_seq_item #(ADDR_SIZE,DATA_SIZE,ID_SIZE));

	//provide implementations of virtual methods such as get_type_name and create
	`uvm_component_param_utils(axil_master_sequencer #(ADDR_SIZE,DATA_SIZE,ID_SIZE))
	
	//new - constructor
	function new (string name="axil_master_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction	: new 

endclass : axil_master_sequencer

`endif //AXI_MASTER_SEQUENCER_SVH
