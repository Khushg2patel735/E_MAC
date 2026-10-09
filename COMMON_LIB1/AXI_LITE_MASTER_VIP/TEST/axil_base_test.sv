`ifndef AXIL_BASE_TEST_SVH
`define AXIL_BASE_TEST_SVH

class axil_base_test extends uvm_test;

	`uvm_component_utils(axil_base_test)
	
	//Instance of ENV and BASE SEQUENCE
	axil_env axil_vc;
  axil_master_base_sequence master_seqs;
  
  
  //axi_cfg instance for make a environment configurable 
	axil_env_config axil_ecfg;
	
	function new (string name = "axil_base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction : new
	
	//build_phase
	virtual function void build_phase(uvm_phase phase);
           super.build_phase(phase);
           axil_ecfg = axil_env_config::type_id::create("axi_ecfg");
           axil_ecfg.is_active = UVM_ACTIVE;
           uvm_config_db #(axil_env_config)::set(this,"*","axi_ecfg",axil_ecfg);
           axil_vc = axil_env::type_id::create("axil_vc",this);
           uvm_config_db #(axil_env)::set(this,"*","axil_vc",axil_vc);
           master_seqs = axil_master_base_sequence #(.ADDR_SIZE(32),.DATA_SIZE(32),.ID_SIZE(32)) ::type_id::create("master_seqs");
	endfunction : build_phase
	
  function void end_of_elaboration_phase (uvm_phase phase);
    super.end_of_elaboration_phase(phase);
     uvm_top.print_topology(); 
  endfunction : end_of_elaboration_phase
	
   
  task run_phase (uvm_phase phase);
    phase.raise_objection(this);
      fork
        master_seqs.start(axil_vc.master_agt[0].master_sequencer);
      join
      #(`CLK_PERIOD * 2);
    phase.drop_objection(this);
  endtask
   
   
endclass : axil_base_test

`endif //AXIL_BASE_TEST_SVH
