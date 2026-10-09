


`ifndef AXIL_BASE_SEQUENCE_SVH
`define AXIL_BASE_SEQUENCE_SVH

class axil_base_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(axil_base_sequence)
  
  axil_env axil_vc;
  axil_master_sequence master_seqs;
  
  axil_master_sequencer master_sequencer[`NUM_AXI_MASTER_AGENTS];
  
	function new(string name = "axil_base_sequence");
		super.new(name);
	endfunction : new  
  
  virtual function void config_base_seq();
    if (!uvm_config_db #(axil_env)::get(null, "uvm_test_top.","axi_vc",axil_vc))
      `uvm_fatal(get_name(),"Get object of axi_vc not successful");
      
      master_sequencer[0] = axil_vc.master_agt[0].master_sequencer;
  endfunction
  
	
endclass : axil_base_sequence

`endif  //AXIL_BASE_SEQUENCE_SVH
	
