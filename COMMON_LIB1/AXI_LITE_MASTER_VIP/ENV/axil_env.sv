/*/********************************************.

* File Name : axil_env.sv

* Purpose :

* Creation Date : 

* Last Modified : 

* Created By : 

************************************************/

`ifndef AXIL_ENV_SVH
`define AXIL_ENV_SVH

class axil_env extends uvm_env;
	
	//virtual Interface
	protected virtual axil_if axil_vif;
		
	//component of environment
	axil_master_agent master_agt[`NUM_AXIL_MASTER_AGENTS];
	
	//provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(axil_env)

	axil_env_config axil_ecfg;
	axil_mas_config axil_mcfg;

	//new - constructor
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction	: new 
	
	//build_phase
	function void build_phase(uvm_phase phase);
		string master_inst_name = "master_agt";
		super.build_phase(phase);
         	//if (!uvm_config_db #(axil_env_config)::get(this,"","axil_ecfg",axil_ecfg))
		//	`uvm_fatal("CONFIG_FAIL","Not able to get env config")	
		axil_mcfg = axil_mas_config::type_id::create("axi_mcfg");
		axil_mcfg.is_active = UVM_ACTIVE;  //axil_ecfg.IS_ACTIVE ;
		uvm_config_db #(axil_mas_config)::set(this,"*","axi_mcfg",axil_mcfg);
     //creating AXIL agents
 		for (int i = 0; i<`NUM_AXIL_MASTER_AGENTS; i++) begin
			master_agt[i] = axil_master_agent #(.ADDR_SIZE(32),.DATA_SIZE(512),.ID_SIZE(32)) ::type_id::create($sformatf("master_agt[%0d]",i),this);
			void'(uvm_config_db #(int)::set(this, {master_inst_name, ".monitor"}, "axil_id", i));
			void'(uvm_config_db #(int)::set(this, {master_inst_name, ".driver"}, "axil_id", i));
			master_agt[i].set_index(i);
		end
    
	endfunction : build_phase

endclass : axil_env

`endif //AXIL_ENV_SVH
